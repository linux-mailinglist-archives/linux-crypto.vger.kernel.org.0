Return-Path: <linux-crypto+bounces-24900-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QDaCGcKbIWphJwEAu9opvQ
	(envelope-from <linux-crypto+bounces-24900-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 17:37:38 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA20A641821
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 17:37:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PWM3G+72;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24900-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24900-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA58F31D0D87
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Jun 2026 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFAC342524;
	Thu,  4 Jun 2026 15:26:12 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC933D6FA;
	Thu,  4 Jun 2026 15:26:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586772; cv=none; b=cPzr+iv7gMYbkd3iEZtmQRkU6TClJy8QhB9230XhDtAuYyVnqh67DTSEIsn+1qtf5IEnS/oBWNSh0392IUgqehWeqDqF5RPMSuBmAGv1OqW2+h2ooLeuso3qj3BUcYH3SaAKKPt/a9Hq7Z+mUF5W0LbjT5cm9OkT6D4wXSxmiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586772; c=relaxed/simple;
	bh=eZJ460EtPnC0csFKiyCck9OhX5GU/pES+//4UIkPtg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKc3P62a3h7IOtMK7ncTkvUiVspFi81Fs0qOdun//Z9Z0XhIKud3KpLLUbwQj5yfTZCp6w/CPp0aW/UQUQFZF3SeiJNbl3dUlCekODhEblX4O6vPx8QGhQIdD//510hg1tt8fzzII2gfRdi/iXlHC9wD+jXVTOUSTMQ3bcXL/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWM3G+72; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610A01F00893;
	Thu,  4 Jun 2026 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780586771;
	bh=L+jH4f8Rpms66fgRIKgKgE5J6WJ4Clco/bQ+lqycTbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PWM3G+724r5Qf3aHW9TpfoUBt8h9jbZT4wsAh4FPYJ831Q8M6xI0e4XhOY5P6Iyij
	 rc5lYX4Vh9pyXFhtMofiP2gM2LrlRB0u6GBkgYdS8HTbkFrdt04vbkKW92eHfySzL5
	 nJXYV+7vKAvZr340HDz9zZjNJBc5HGcsyl068iwZGOWRA0Xhc78ZiK+q7n3gWsZ2iK
	 gFBttjHxXR52T6weZ0wvXQgMRFn4eMuhLZlep909YTvQ5dcaekOagdOpA/N4xtwOiV
	 5bMM+ssnWIjz4Or8tvURdDapCJjSUAAiPEy3aAs/luNDlEBHyGG6JjpXa9T41NNV7s
	 UKUPC3GHLTfMg==
Message-ID: <d2d0e0d7-9d76-4384-9c55-273d143e3a95@kernel.org>
Date: Thu, 4 Jun 2026 17:26:04 +0200
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/29] crypto: talitos - Replace SEC1/SEC2 conditionals
 with ops dispatch
To: Paul Louvel <paul.louvel@bootlin.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260528-7-1-rc1_talitos_cleanup-v1-0-cb1ad6cdea49@bootlin.com>
 <20260528-7-1-rc1_talitos_cleanup-v1-20-cb1ad6cdea49@bootlin.com>
 <5dce751a-0d48-467e-b8c9-6702366cfd06@kernel.org>
 <DJ0ACBGP13QP.3UJ74J9XFHOBX@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <DJ0ACBGP13QP.3UJ74J9XFHOBX@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24900-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[chleroy@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:paul.louvel@bootlin.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:thomas.petazzoni@bootlin.com,m:herve.codina@bootlin.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA20A641821



Le 04/06/2026 à 15:05, Paul Louvel a écrit :
> On Thu Jun 4, 2026 at 11:37 AM CEST, Christophe Leroy (CS GROUP) wrote:
>>
>>
>> Le 28/05/2026 à 11:08, Paul Louvel a écrit :
>>> Replace the if/else is_sec1 dispatches in callers with indirect calls
>>> through priv->ops. Add static const sec1_ops and sec2_ops structs
>>> populated with the SEC1 and SEC2 function variants, and set priv->ops
>>> at probe time based on the detected hardware.
>>
>> Why is that needed ?
>>
>> I understand your objective at the end is to get rid of that is_sec1
>> boolean that is carried over the entire call chain but using ops for
>> that seems overkill.
>>
>> What about changing it to a helper using static branches, something like
>> (untested) :
>>
>> #if defined(CONFIG_CRYPTO_DEV_TALITOS1) &&
>> defined(CONFIG_CRYPTO_DEV_TALITOS2)
>> DECLARE_STATIC_KEY_FALSE(talitos_is_sec1);
>> static __always_inline bool is_sec1(void)
>> {
>> 	return static_branch_unlikely(&talitos_is_sec1);
>> }
>>
>> static inline void talitos_init_branch(bool is_sec1)
>> {
>> 	if (is_sec1)
>> 		static_branch_enable(&talitos_is_sec1);
>> }
>> #else
>> static __always_inline bool is_sec1(void)
>> {
>> 	return IS_ENABLED(CONFIG_CRYPTO_DEV_TALITOS1);
>> }
>>
>> static inline void talitos_init_branch(bool is_sec1)
>> {
>> 	BUILD_BUG_ON(is_sec1 && !IS_ENABLED(CONFIG_CRYPTO_DEV_TALITOS1));
>> }
>> #endif
>>
> 
> Thanks you for that suggestion.
> This was a lack of knowledge about this mechanism.

static_branch is nice for small inlined helpers.

For bigger time critical functions, you have static calls.

See exemple in commit e59596a2d6a7 ("powerpc: Use static call for 
get_irq()")

This has become even more efficient since commit f50b45626e05 
("powerpc/static_call: Implement inline static calls")

Christophe


