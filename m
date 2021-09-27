Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89174190D1
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Sep 2021 10:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhI0I3s (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Sep 2021 04:29:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39156 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhI0I3r (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Sep 2021 04:29:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 677E6200A6;
        Mon, 27 Sep 2021 08:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632731288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IzRpYwg8XT7vqE3k6YtV2nkJvw9ef0chxy96R0/2zc=;
        b=q2SeJiyoATb/nFqXahyThP6f+tYr9iVAVwI2c3lDR2PUY2S15S8/Ypm9Jxf5t1fXuZNdXu
        pUPAAn9LWXAm9iH+jFz/OBfZ4WWo7cMXOGzSSQFGuK9bT/dzFTB2VDIpzSLtLXlgktXY5/
        dtDoXTsunBz2yLUVDZc7eb+k6MRQ8zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632731288;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IzRpYwg8XT7vqE3k6YtV2nkJvw9ef0chxy96R0/2zc=;
        b=8dGSvjyAhu/5S+MPWY4rT17aVeit96nwuD+ExfHdg0pUPjNnFkQiWgYe4olvYL0zoS0XBb
        qldZABuxJqXfJ0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A0F613A42;
        Mon, 27 Sep 2021 08:28:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jGylFZiAUWF8TQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 27 Sep 2021 08:28:08 +0000
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-11-hare@suse.de>
 <79742bd7-a41c-0abc-e7de-8d222b146d02@grimberg.me>
 <c7739610-6d0b-7740-c339-b35ca5ae34e2@suse.de>
 <a2596777-25b2-f633-4b00-18b1a319c5c2@suse.de>
 <32d8f860-9fdb-606c-62b7-ad89837d8e71@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2ccfb62a-d782-7bb2-4d41-6d1152851a4a@suse.de>
Date:   Mon, 27 Sep 2021 10:28:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <32d8f860-9fdb-606c-62b7-ad89837d8e71@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 9/27/21 9:55 AM, Sagi Grimberg wrote:
> 
> 
> On 9/27/21 10:17 AM, Hannes Reinecke wrote:
>> On 9/27/21 8:40 AM, Hannes Reinecke wrote:
>>> On 9/27/21 12:51 AM, Sagi Grimberg wrote:
>>>>
>>>>> +void nvmet_execute_auth_send(struct nvmet_req *req)
>>>>> +{
>>>>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>>>> +    struct nvmf_auth_dhchap_success2_data *data;
>>>>> +    void *d;
>>>>> +    u32 tl;
>>>>> +    u16 status = 0;
>>>>> +
>>>>> +    if (req->cmd->auth_send.secp !=
>>>>> NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
>>>>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>>>> +        req->error_loc =
>>>>> +            offsetof(struct nvmf_auth_send_command, secp);
>>>>> +        goto done;
>>>>> +    }
>>>>> +    if (req->cmd->auth_send.spsp0 != 0x01) {
>>>>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>>>> +        req->error_loc =
>>>>> +            offsetof(struct nvmf_auth_send_command, spsp0);
>>>>> +        goto done;
>>>>> +    }
>>>>> +    if (req->cmd->auth_send.spsp1 != 0x01) {
>>>>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>>>> +        req->error_loc =
>>>>> +            offsetof(struct nvmf_auth_send_command, spsp1);
>>>>> +        goto done;
>>>>> +    }
>>>>> +    tl = le32_to_cpu(req->cmd->auth_send.tl);
>>>>> +    if (!tl) {
>>>>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>>>> +        req->error_loc =
>>>>> +            offsetof(struct nvmf_auth_send_command, tl);
>>>>> +        goto done;
>>>>> +    }
>>>>> +    if (!nvmet_check_transfer_len(req, tl)) {
>>>>> +        pr_debug("%s: transfer length mismatch (%u)\n", __func__,
>>>>> tl);
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    d = kmalloc(tl, GFP_KERNEL);
>>>>> +    if (!d) {
>>>>> +        status = NVME_SC_INTERNAL;
>>>>> +        goto done;
>>>>> +    }
>>>>> +
>>>>> +    status = nvmet_copy_from_sgl(req, 0, d, tl);
>>>>> +    if (status) {
>>>>> +        kfree(d);
>>>>> +        goto done;
>>>>> +    }
>>>>> +
>>>>> +    data = d;
>>>>> +    pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,
>>>>> +         ctrl->cntlid, req->sq->qid, data->auth_type, data->auth_id,
>>>>> +         req->sq->dhchap_step);
>>>>> +    if (data->auth_type != NVME_AUTH_COMMON_MESSAGES &&
>>>>> +        data->auth_type != NVME_AUTH_DHCHAP_MESSAGES)
>>>>> +        goto done_failure1;
>>>>> +    if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
>>>>> +        if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
>>>>> +            /* Restart negotiation */
>>>>> +            pr_debug("%s: ctrl %d qid %d reset negotiation\n",
>>>>> __func__,
>>>>> +                 ctrl->cntlid, req->sq->qid);
>>>>
>>>> This is the point where you need to reset also auth config as this may
>>>> have changed and the host will not create a new controller but rather
>>>> re-authenticate on the existing controller.
>>>>
>>>> i.e.
>>>>
>>>> +                       if (!req->sq->qid) {
>>>> +                               nvmet_destroy_auth(ctrl);
>>>> +                               if (nvmet_setup_auth(ctrl) < 0) {
>>>> +                                       pr_err("Failed to setup
>>>> re-authentication\n");
>>>> +                                       goto done_failure1;
>>>> +                               }
>>>> +                       }
>>>>
>>>>
>>>>
>>>
>>> Not sure. We have two paths how re-authentication can be triggered.
>>> The one is from the host, which sends a 'negotiate' command to the
>>> controller (ie this path).  Then nothing on the controller has
>>> changed, and we just need to ensure that we restart negotiation.
>>> IE we should _not_ reset the authentication (as that would also
>>> remove the controller keys, which haven't changed). We should just
>>> ensure that all ephemeral data is regenerated. But that should be
>>> handled in-line, and I _think_ I have covered all of that.
>>> The other path to trigger re-authentication is when changing values
>>> on the controller via configfs. Then sure we need to reset the
>>> controller data, and trigger reauthentication.
>>> And there I do agree, that path isn't fully implemented / tested.
>>> But should be started whenever the configfs values change.
>>>
>> Actually, having re-read the spec I'm not sure if the second path is
>> correct.
>> As per spec only the _host_ can trigger re-authentication. There is no
>> provision for the controller to trigger re-authentication, and given
>> that re-auth is a soft-state anyway (ie the current authentication
>> stays valid until re-auth enters a final state) I _think_ we should be
>> good with the current implementation, where we can change the
>> controller keys
>> via configfs, but they will only become active once the host triggers
>> re-authentication.
> 
> Agree, so the proposed addition is good with you?
> 
Why would we need it?
I do agree there's a bit missing for removing the old shash_tfm if there
is a hash-id mismatch, but why would we need to reset the entire
authentication?
The important (ie cryptographically relevant) bits are cleared in
nvmet_auth_sq_free(), and they are cleared after authentication is
completed.
So why would we need to reset keys and TFMs?

>> And indeed, that's the only way how it could work, otherwise it'll be
>> tricky to change keys in a running connection.
>> If we were to force renegotiation when changing controller keys we
>> would immediately fail the connection, as we cannot guarantee that
>> controller _and_ host keys are changed at the same time.
> 
> Exactly, changing the hostkey in the controller must not trigger
> re-auth, the host will remain connected and operational as it
> authenticated before. As the host re-authenticates or reconnect
> it needs to authenticate against the new key.

Right. I'll be adding a comment to the configfs functions to the effect.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
