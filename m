Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40363534D8
	for <lists+linux-crypto@lfdr.de>; Sat,  3 Apr 2021 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhDCRNu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 3 Apr 2021 13:13:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55540 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236724AbhDCRNt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 3 Apr 2021 13:13:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FCNml41kPz9v2DJ;
        Sat,  3 Apr 2021 19:13:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8DTnTeSpR-u2; Sat,  3 Apr 2021 19:13:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FCNml2tcJz9v2DC;
        Sat,  3 Apr 2021 19:13:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 16DC78B76D;
        Sat,  3 Apr 2021 19:13:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YZX0c__H92mI; Sat,  3 Apr 2021 19:13:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 323038B76A;
        Sat,  3 Apr 2021 19:13:44 +0200 (CEST)
Subject: Re: [PATCH 3/5] crypto: ccp: Play nice with vmalloc'd memory for SEV
 command structs
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
References: <20210402233702.3291792-1-seanjc@google.com>
 <20210402233702.3291792-4-seanjc@google.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8a9c02a4-e17f-5191-bd93-6c8dd654a30a@csgroup.eu>
Date:   Sat, 3 Apr 2021 19:13:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210402233702.3291792-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



Le 03/04/2021 à 01:37, Sean Christopherson a écrit :
> Copy vmalloc'd data to an internal buffer instead of rejecting outright
> so that callers can put SEV command buffers on the stack without running
> afoul of CONFIG_VMAP_STACK=y.  Currently, the largest supported command
> takes a 68 byte buffer, i.e. pretty much every command can be put on the
> stack.  Because sev_cmd_mutex is held for the entirety of a transaction,
> only a single bounce buffer is required.
> 
> Use a flexible array for the buffer, sized to hold the largest known
> command.   Alternatively, the buffer could be a union of all known
> command structs, but that would incur a higher maintenance cost due to
> the need to update the union for every command in addition to updating
> the existing sev_cmd_buffer_len().
> 
> Align the buffer to an 8-byte boundary, mimicking the alignment that
> would be provided by the compiler if any of the structs were embedded
> directly.  Note, sizeof() correctly incorporates this alignment.
> 
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   drivers/crypto/ccp/sev-dev.c | 33 +++++++++++++++++++++++++++------
>   drivers/crypto/ccp/sev-dev.h |  7 +++++++
>   2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 4c513318f16a..6d5882290cfc 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -135,13 +135,14 @@ static int sev_cmd_buffer_len(int cmd)
>   	return 0;
>   }
>   
> -static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
> +static int __sev_do_cmd_locked(int cmd, void *__data, int *psp_ret)
>   {
>   	struct psp_device *psp = psp_master;
>   	struct sev_device *sev;
>   	unsigned int phys_lsb, phys_msb;
>   	unsigned int reg, ret = 0;
>   	int buf_len;
> +	void *data;
>   
>   	if (!psp || !psp->sev_data)
>   		return -ENODEV;
> @@ -152,11 +153,21 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>   	sev = psp->sev_data;
>   
>   	buf_len = sev_cmd_buffer_len(cmd);
> -	if (WARN_ON_ONCE(!!data != !!buf_len))
> +	if (WARN_ON_ONCE(!!__data != !!buf_len))

Why do you need a double !! ?
I think !__data != !buf_len should be enough.

>   		return -EINVAL;
>   
> -	if (WARN_ON_ONCE(data && is_vmalloc_addr(data)))
> -		return -EINVAL;
> +	if (__data && is_vmalloc_addr(__data)) {
> +		/*
> +		 * If the incoming buffer is virtually allocated, copy it to
> +		 * the driver's scratch buffer as __pa() will not work for such
> +		 * addresses, vmalloc_to_page() is not guaranteed to succeed,
> +		 * and vmalloc'd data may not be physically contiguous.
> +		 */
> +		data = sev->cmd_buf;
> +		memcpy(data, __data, buf_len);
> +	} else {
> +		data = __data;
> +	}
>   
>   	/* Get the physical address of the command buffer */
>   	phys_lsb = data ? lower_32_bits(__psp_pa(data)) : 0;
> @@ -204,6 +215,13 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>   	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
>   			     buf_len, false);
>   
> +	/*
> +	 * Copy potential output from the PSP back to __data.  Do this even on
> +	 * failure in case the caller wants to glean something from the error.
> +	 */
> +	if (__data && data != __data)

IIUC, when __data is NULL, data is also NULL, so this double test is useless.

Checking data != __data should be enough

> +		memcpy(__data, data, buf_len);
> +
>   	return ret;
>   }
>   
> @@ -978,9 +996,12 @@ int sev_dev_init(struct psp_device *psp)
>   {
>   	struct device *dev = psp->dev;
>   	struct sev_device *sev;
> -	int ret = -ENOMEM;
> +	int ret = -ENOMEM, cmd_buf_size = 0, i;
>   
> -	sev = devm_kzalloc(dev, sizeof(*sev), GFP_KERNEL);
> +	for (i = 0; i < SEV_CMD_MAX; i++)
> +		cmd_buf_size = max(cmd_buf_size, sev_cmd_buffer_len(i));
> +
> +	sev = devm_kzalloc(dev, sizeof(*sev) + cmd_buf_size, GFP_KERNEL);
>   	if (!sev)
>   		goto e_err;
>   
> diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
> index dd5c4fe82914..b43283ce2d73 100644
> --- a/drivers/crypto/ccp/sev-dev.h
> +++ b/drivers/crypto/ccp/sev-dev.h
> @@ -52,6 +52,13 @@ struct sev_device {
>   	u8 api_major;
>   	u8 api_minor;
>   	u8 build;
> +
> +	/*
> +	 * Buffer used for incoming commands whose physical address cannot be
> +	 * resolved via __pa(), e.g. stack pointers when CONFIG_VMAP_STACK=y.
> +	 * Note, alignment isn't strictly required.
> +	 */
> +	u8 cmd_buf[] __aligned(8);
>   };
>   
>   int sev_dev_init(struct psp_device *psp);
> 
