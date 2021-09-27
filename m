Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465F3418CE4
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Sep 2021 00:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhIZWxw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 26 Sep 2021 18:53:52 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:38887 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhIZWxg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 26 Sep 2021 18:53:36 -0400
Received: by mail-ed1-f53.google.com with SMTP id dj4so61371961edb.5
        for <linux-crypto@vger.kernel.org>; Sun, 26 Sep 2021 15:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34p6t/Gjm3fHsHlQm7MJAedTKeurhIWFu17O3mHId8o=;
        b=vgvDop/lEiO1DRDhWd57A9FG5bXymSeB1wtiLYTtiz6VyK1qOe92iCrfck1aVILXTx
         2joi9xCYgNZjWAh4IAiRiHlqvqKG3VbkUsTtkQqv3FAJfNW4Qv7XJvvwOpdZeNLnOQvk
         dp2Dp0d4QcugpvYS4pmDF8RrOQo90A4MNUqvXJ/EES6COts4IRRJyM9U31AApryOa/BW
         g8hI3Q84wGShPE95V06RapYc0fBQwkQTnGOUjBuVxU0hcQSKK8eX+JzaC1586Umn1BCv
         igRPy90HGvjFkFfsKCiWM3TqnudBafnbkq1i58pZK8Ei+VTz2i47Q7xx2QYUe9olcQFq
         5d4Q==
X-Gm-Message-State: AOAM531xsNvNxAJvqKMpqiA8iiqKvsdFOZFjgpfEoXAXWGxpncogU8rz
        tkLCcIOHHI5IMkSVMol4ETsTvoLB2Nk=
X-Google-Smtp-Source: ABdhPJxu3O7qMNKBhQBLNriFNofjdDaQIjpH+nduCfd7jGYzQIpIgW+ePdCWgwZ0i8oB7SkDa0uKOA==
X-Received: by 2002:a17:906:3745:: with SMTP id e5mr23770118ejc.400.1632696718253;
        Sun, 26 Sep 2021 15:51:58 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il. [109.186.240.23])
        by smtp.gmail.com with ESMTPSA id n25sm9626871eda.95.2021.09.26.15.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 15:51:57 -0700 (PDT)
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-11-hare@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <79742bd7-a41c-0abc-e7de-8d222b146d02@grimberg.me>
Date:   Mon, 27 Sep 2021 01:51:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910064322.67705-11-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


> +void nvmet_execute_auth_send(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmf_auth_dhchap_success2_data *data;
> +	void *d;
> +	u32 tl;
> +	u16 status = 0;
> +
> +	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, secp);
> +		goto done;
> +	}
> +	if (req->cmd->auth_send.spsp0 != 0x01) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, spsp0);
> +		goto done;
> +	}
> +	if (req->cmd->auth_send.spsp1 != 0x01) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, spsp1);
> +		goto done;
> +	}
> +	tl = le32_to_cpu(req->cmd->auth_send.tl);
> +	if (!tl) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, tl);
> +		goto done;
> +	}
> +	if (!nvmet_check_transfer_len(req, tl)) {
> +		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
> +		return;
> +	}
> +
> +	d = kmalloc(tl, GFP_KERNEL);
> +	if (!d) {
> +		status = NVME_SC_INTERNAL;
> +		goto done;
> +	}
> +
> +	status = nvmet_copy_from_sgl(req, 0, d, tl);
> +	if (status) {
> +		kfree(d);
> +		goto done;
> +	}
> +
> +	data = d;
> +	pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,
> +		 ctrl->cntlid, req->sq->qid, data->auth_type, data->auth_id,
> +		 req->sq->dhchap_step);
> +	if (data->auth_type != NVME_AUTH_COMMON_MESSAGES &&
> +	    data->auth_type != NVME_AUTH_DHCHAP_MESSAGES)
> +		goto done_failure1;
> +	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
> +		if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
> +			/* Restart negotiation */
> +			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
> +				 ctrl->cntlid, req->sq->qid);

This is the point where you need to reset also auth config as this may
have changed and the host will not create a new controller but rather
re-authenticate on the existing controller.

i.e.

+                       if (!req->sq->qid) {
+                               nvmet_destroy_auth(ctrl);
+                               if (nvmet_setup_auth(ctrl) < 0) {
+                                       pr_err("Failed to setup 
re-authentication\n");
+                                       goto done_failure1;
+                               }
+                       }



> +			req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
> +		} else if (data->auth_id != req->sq->dhchap_step)
> +			goto done_failure1;
> +		/* Validate negotiation parameters */
> +		status = nvmet_auth_negotiate(req, d);/
