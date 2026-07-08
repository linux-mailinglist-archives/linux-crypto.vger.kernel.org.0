Return-Path: <linux-crypto+bounces-25737-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PULnK4hoTmqBMAIAu9opvQ
	(envelope-from <linux-crypto+bounces-25737-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 17:11:04 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D79727CAE
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 17:11:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VZE4IpdL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25737-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25737-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 599E5306DCEC
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Jul 2026 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47203F12F6;
	Wed,  8 Jul 2026 15:03:57 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A043DD521;
	Wed,  8 Jul 2026 15:03:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523037; cv=none; b=ZF4u+RqgrrCFss8agW2CLAyakwH13STtT6civ8q5wqCulph7v8649OPXoDOSX4RBevKCAhoRVf0AHB/sudD2i7YmoGC1DqI92PL/2GAUaXSqFwjt5o8mCT5PZbYohoRh7eKMb6J4s6LG/QlO0RYQNSpSXrzlrYmTDm70wI1yaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523037; c=relaxed/simple;
	bh=ozbDkpERH6eS7Si13V6qz2k1Ockh5KC4ASIiPUGSquM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzoXD8s0Y7vtEjaD24cpdWu2m3XS+hNjTCFah44/punG74VAgsEPOJYDfCisJqe/YmqG4VQDI0P0i1oqW7Z/VMxOA22P+KzAJG8Mp2zZeeDINaR1Yd8KvhDOxwUv8uoCrNnqlKmFbbsjQtAANOQbyT6vpseklUyUFEyhLe6HiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZE4IpdL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E142E1F000E9;
	Wed,  8 Jul 2026 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783523035;
	bh=6lOoLeoST3DsMEdt45LFc9dqUSr7Eq3hHB2+CBF1gOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VZE4IpdLkxSA6/ssYYZglkjwkarWp6PACqjBRVN7rZMu33kN7uVCm/knysW6QSxZW
	 qeND1nAPyQQJmjSqDfNZ71w1L5I+fdTjACI7TO14Yh12lHGkEhmY+U370bqAf71zSZ
	 o2GXktfup2Kkp4owd9aOPSiKZ6Gm0OHtDX2o/DqBTWkNZLk/bwtuDvykxzbjlFb5NR
	 tUd+i6MlfWmAAyeF2BnbsrH7kdHbB0c93/WSBstR/gp9FQe+86i2xqf8sPTcPFZVC4
	 EzuSibQyyuupSkfC0kvE1koG9lxW2yshIiE8CZBCmN3RRAGUFANXL/K5+ubEDeXPOT
	 +rNumVN+199nw==
Date: Wed, 8 Jul 2026 16:03:51 +0100
From: Lee Jones <lee@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: chenhuacai@kernel.org, xry111@xry111.site, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mfd: loongson-se: Add multi-node support
Message-ID: <20260708150351.GI2108533@google.com>
References: <20260629071109.7341-1-zhaoqunqin@loongson.cn>
 <20260629071109.7341-3-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629071109.7341-3-zhaoqunqin@loongson.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zhaoqunqin@loongson.cn,m:chenhuacai@kernel.org,m:xry111@xry111.site,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lee@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25737-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,head.next:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47D79727CAE

Same here please.

/* Sashiko Automation: Issues Found (6 Findings) */

On Mon, 29 Jun 2026, Qunqin Zhao wrote:

> On the Loongson platform, each node is equipped with a security engine
> device. However, due to a hardware flaw, only the device on node 0 can
> trigger interrupts. Therefore, interrupts from other nodes are forwarded
> by node 0. We need to check in the interrupt handler of node 0 whether
> this interrupt is intended for other nodes, this can be accomplished via
> shared interrupt handling.
> 
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
>  drivers/mfd/loongson-se.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/loongson-se.c b/drivers/mfd/loongson-se.c
> index aa34e663c4..2f296faa97 100644
> --- a/drivers/mfd/loongson-se.c
> +++ b/drivers/mfd/loongson-se.c
> @@ -142,6 +142,11 @@ static irqreturn_t se_irq_handler(int irq, void *dev_id)
>  
>  	int_status = readl(se->base + SE_S2LINT_STAT);
>  
> +	if (int_status == 0) {
> +		spin_unlock(&se->dev_lock);
> +		return IRQ_NONE;
> +	}
> +
>  	/* For controller */
>  	if (int_status & SE_INT_CONTROLLER) {
>  		complete(&se->cmd_completion);
> @@ -222,7 +227,7 @@ static int loongson_se_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < nr_irq; i++) {
>  		irq = platform_get_irq(pdev, i);
> -		err = devm_request_irq(dev, irq, se_irq_handler, 0, "loongson-se", se);
> +		err = devm_request_irq(dev, irq, se_irq_handler, IRQF_SHARED, "loongson-se", se);

[Severity: High]
Could unmasking interrupts before registering the shared handler create a
race condition?

Because writel(SE_INT_ALL, se->base + SE_S2LINT_EN) is called earlier in
loongson_se_probe() to unmask interrupts, registering a shared interrupt
handler here means that if node 1's interrupts are unmasked, it could
instantly assert the shared IRQ line.

Since node 1 hasn't fully registered its handler yet, node 0's handler might
return IRQ_NONE, causing the kernel to repeatedly receive an unhandled
interrupt and eventually disable the IRQ line.



[Severity: High]
This is a pre-existing issue, but might the new use of IRQF_SHARED expose an
uninitialized completion object in the interrupt handler?

The completion structures for the engines are zero-allocated via
devm_kzalloc() in loongson_se_probe() and are only initialized later in
loongson_se_init_engine().

If a pending or spurious engine interrupt fires on the shared line before
the child engine devices are fully initialized, the handler will execute:

se_irq_handler()
    ...
    while (int_status) {
        id = __ffs(int_status);
        if (id < SE_ENGINE_MAX)
            complete(&se->engines[id].completion);

Calling complete() here on a zeroed structure dereferences a NULL
wait.head.next pointer, which could cause a kernel panic.


>  		if (err) {
>  			dev_err(dev, "failed to request IRQ: %d\n", irq);
>  			return err;
> @@ -233,7 +238,7 @@ static int loongson_se_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, engines,
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, engines,
>  				    ARRAY_SIZE(engines), NULL, 0, NULL);
>  }

[Severity: Critical]
This isn't a bug introduced by this patch, but does the probe error path leak
running hardware state?

loongson_se_init() configures the hardware to use the allocated DMA memory
and sends SE_CMD_START. If devm_mfd_add_devices() fails here, the probe
returns an error and devres frees the DMA memory.

However, the hardware is never sent SE_CMD_STOP in the error path. It
remains active and retains a pointer to the freed DMA memory, which could
allow it to corrupt system memory via DMA.



[Severity: High]
This is a pre-existing issue, but are hardware interrupts left globally
enabled if probe fails or the device is removed?

loongson_se_probe() unconditionally enables all hardware interrupts earlier
via writel(SE_INT_ALL, se->base + SE_S2LINT_EN). If devm_mfd_add_devices()
fails, the probe function returns an error and the IRQ handler is
unregistered, but the hardware interrupts are never masked.

Similarly, loongson_se_remove() stops the controller but fails to write 0
to the interrupt enable register.

Because the IRQ is shared, a pending interrupt from this device could
continuously trigger the shared IRQ line without a registered handler to
clear it, causing an unhandled interrupt storm that forces the kernel to
permanently disable the IRQ line.

While reviewing the completion handling in this driver, I noticed a couple
other pre-existing issues outside the scope of this diff:



[Severity: High]
This isn't a bug introduced by this patch, but does re-initializing the
completion variable after triggering the hardware create a race condition?

Looking at loongson_se_send_engine_cmd():

loongson_se_send_engine_cmd()
    ...
    loongson_se_poll() // triggers hardware and reenables interrupts
    ...
    reinit_completion(&engine->completion);
    ...
    wait_for_completion_interruptible(&engine->completion);

If the hardware completes the command quickly after loongson_se_poll()
unmasks interrupts, it triggers an interrupt. The handler will call
complete(), but then execution resumes in loongson_se_send_engine_cmd()
where reinit_completion() clears the completion state.

This would cause the subsequent wait_for_completion_interruptible() to hang
indefinitely since the completion event was lost.



[Severity: High]
This is a pre-existing issue, but could missing completion re-initialization
cause controller commands to falsely return success?

Looking at loongson_se_send_controller_cmd():

loongson_se_send_controller_cmd()
    ...
    // hardware triggered
    return wait_for_completion_interruptible(&se->cmd_completion);

The function waits on the completion without first calling
reinit_completion() to clear any leftover state.

If a previous wait was interrupted by a signal (returning -ERESTARTSYS),
the hardware may still complete later, leaving a positive done count in
the completion structure. On the next call to
loongson_se_send_controller_cmd(), wait_for_completion_interruptible()
would immediately consume the leftover count and return success before the
new hardware command has actually finished. This could break serialization
and corrupt hardware or DMA state.

>  
> -- 
> 2.47.2
> 

-- 
Lee Jones

