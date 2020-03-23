Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5E18F432
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Mar 2020 13:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCWMPr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 23 Mar 2020 08:15:47 -0400
Received: from ozlabs.org ([203.11.71.1]:38977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgCWMPq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 23 Mar 2020 08:15:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48mCyS1JjFz9sPk;
        Mon, 23 Mar 2020 23:15:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1584965744;
        bh=clICM/h45Y0TLcKljhCWbD7p0IYWviTAYxYUMIhnrTY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=m5YBGXXbBMNrReym7cIcW3kjWBuj5kAEVGFVXTd1vg1rtvVPfknsIzk2s1WvS624i
         j+e5hM0+cpULR0l+ew3iprHbjKN45XAVb0WZ5wkMrqOtvS8pQI1XeoMwvReKqIV7Iv
         x8DFQucBNV/FMQWtxIBJARNVyzZ+Az4zy08t9+4a+rz00lp9s0BtGJvLZJlhbXPzYe
         fxlwxEhA/2xuLEUtZW3I98Kk2XIhLN9hz4Ig4Wri46VLNaSPr5LM7MQmYVlQxJVgjN
         FojHm1hSBBDzeDTj/6F8L0p+pp08HWiMDBBL1dOyzVxXLWw7OnMcIeeNRHiOWx5jgt
         wwgeMDmcESEEA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>, Haren Myneni <haren@linux.ibm.com>,
        herbert@gondor.apana.org.au
Cc:     mikey@neuling.org, sukadev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        npiggin@gmail.com
Subject: Re: [PATCH v4 3/9] powerpc/vas: Add VAS user space API
In-Reply-To: <878sjrwm72.fsf@dja-thinkpad.axtens.net>
References: <1584934879.9256.15321.camel@hbabu-laptop> <1584936142.9256.15325.camel@hbabu-laptop> <878sjrwm72.fsf@dja-thinkpad.axtens.net>
Date:   Mon, 23 Mar 2020 23:15:48 +1100
Message-ID: <878sjrclmz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> Haren Myneni <haren@linux.ibm.com> writes:
>
>> On power9, userspace can send GZIP compression requests directly to NX
>> once kernel establishes NX channel / window with VAS. This patch provides
>> user space API which allows user space to establish channel using open
>> VAS_TX_WIN_OPEN ioctl, mmap and close operations.
>>
>> Each window corresponds to file descriptor and application can open
>> multiple windows. After the window is opened, VAS_TX_WIN_OPEN icoctl to
>> open a window on specific VAS instance, mmap() system call to map
>> the hardware address of engine's request queue into the application's
>> virtual address space.
>>
>> Then the application can then submit one or more requests to the the
>> engine by using the copy/paste instructions and pasting the CRBs to
>> the virtual address (aka paste_address) returned by mmap().
>>
>> Only NX GZIP coprocessor type is supported right now and allow GZIP
>> engine access via /dev/crypto/nx-gzip device node.
>>
>> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/vas.h              |  11 ++
>>  arch/powerpc/platforms/powernv/Makefile     |   2 +-
>>  arch/powerpc/platforms/powernv/vas-api.c    | 257 ++++++++++++++++++++++++++++
>>  arch/powerpc/platforms/powernv/vas-window.c |   6 +-
>>  arch/powerpc/platforms/powernv/vas.h        |   2 +
>>  5 files changed, 274 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/powerpc/platforms/powernv/vas-api.c
>>
>> diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
>> index f93e6b0..e064953 100644
>> --- a/arch/powerpc/include/asm/vas.h
>> +++ b/arch/powerpc/include/asm/vas.h
>> @@ -163,4 +163,15 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
>>   */
>>  int vas_paste_crb(struct vas_window *win, int offset, bool re);
>>  
>> +/*
>> + * Register / unregister coprocessor type to VAS API which will be exported
>> + * to user space. Applications can use this API to open / close window
>> + * which can be used to send / receive requests directly to cooprcessor.
>> + *
>> + * Only NX GZIP coprocessor type is supported now, but this API can be
>> + * used for others in future.
>> + */
>> +int vas_register_coproc_api(struct module *mod);
>> +void vas_unregister_coproc_api(void);
>> +
>>  #endif /* __ASM_POWERPC_VAS_H */
>> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
>> index 395789f..fe3f0fb 100644
>> --- a/arch/powerpc/platforms/powernv/Makefile
>> +++ b/arch/powerpc/platforms/powernv/Makefile
>> @@ -17,7 +17,7 @@ obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
>>  obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
>>  obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
>>  obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
>> -obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o vas-fault.o
>> +obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o vas-fault.o vas-api.o
>>  obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
>>  obj-$(CONFIG_SCOM_DEBUGFS) += opal-xscom.o
>>  obj-$(CONFIG_PPC_SECURE_BOOT) += opal-secvar.o
>> diff --git a/arch/powerpc/platforms/powernv/vas-api.c b/arch/powerpc/platforms/powernv/vas-api.c
>> new file mode 100644
>> index 0000000..7d049af
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/powernv/vas-api.c
>> @@ -0,0 +1,257 @@
...
>> +
>> +static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
>> +{
>> +	struct vas_window *txwin = fp->private_data;
>> +	unsigned long pfn;
>> +	u64 paste_addr;
>> +	pgprot_t prot;
>> +	int rc;
>> +
>> +	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
>
> I think you said this should be 4096 rather than 64k, regardless of what
> PAGE_SIZE you are compiled with?

You can't mmap less than a page, a page is PAGE_SIZE bytes.

So if that checked for 4K explicitly it would prevent mmap on 64K
kernels always, which seems like not what you want?

cheers
