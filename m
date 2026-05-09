Return-Path: <linux-crypto+bounces-23888-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /ckqKiya/2kT8QAAu9opvQ
	(envelope-from <linux-crypto+bounces-23888-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 09 May 2026 22:33:48 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 328045015BF
	for <lists+linux-crypto@lfdr.de>; Sat, 09 May 2026 22:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03C98300381F
	for <lists+linux-crypto@lfdr.de>; Sat,  9 May 2026 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA023ED5B;
	Sat,  9 May 2026 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="V/JOr9Oa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArOyGU3l"
X-Original-To: linux-crypto@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E67E2F8E8F;
	Sat,  9 May 2026 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778358822; cv=none; b=I15Q0l0N3Y3lNF2QHejF49lQJCIZeA/F7AVvURashR69jTbnU8ZorMSMRthB6f2WkCOqNsErrf7mUpd8w7ENip0TTFnkaNMY0OP0cUdvdsTVpCgqBk8MYCtOKPJgLBI3x6mEWQVLvbJ4J/jPOSpmsITYLSjFIiBRidVgs65hdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778358822; c=relaxed/simple;
	bh=Lscc/e8hk4rSAJ5u+A++9jIfii2y6AHTLuko/R6Ox0w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cS632qxXcBo6m08wAPOVCJxbI4VOf4xUSXpdlYwsNWv053lZV1ygLFPoeSTSHeRhvVWeO6nlM8FuZXASOnfycZmt+8AM7FNwhs/AXgbLjjmiW5ZlHWSMWRT9y/we52+JyPVSlJws+zkNyNCK0dLA4jDFigIlOEvLRznln/hcwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=V/JOr9Oa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArOyGU3l; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id AF7881D00054;
	Sat,  9 May 2026 16:33:38 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Sat, 09 May 2026 16:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778358818;
	 x=1778445218; bh=xxb1o17JXihaenZdPmnSQRmPxQEVKPEXTDoHbn1RBpU=; b=
	V/JOr9OaQTLYVW30NndG+L7VPvlDy+LYm0Kub7u5v+zTWlpcyJB3tWKB9mLgASNB
	t7yASuCpNTdS4VT6bvfNidW2pfH7v6NRmqELVMlP6Nuy08kn7WQJFJ0AJKo697sS
	9Lh/fFeGABnrwN4GMlkmGb0ZRgt4J/2La7FWi+DKMlXCwAXpFLTbQmzj+JtxCglM
	KNWkT9ucLLOcOFVY2tN1W7t9UyGaWWHL7hwn8dAGeubDc4nw2kRMmRtQ5T3jFwLo
	JGm6SYEDegUKLvawIF1wmQV7KLbq79GPT+Y3j1DCdrq/m3z9m7ObAYdrpxxHUtTi
	jN9nULWQN3n2/SnhoTIjXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778358818; x=
	1778445218; bh=xxb1o17JXihaenZdPmnSQRmPxQEVKPEXTDoHbn1RBpU=; b=A
	rOyGU3lg3s7Oa9hIJdX1gEEuJHLGgkz8URgShUpQ++b9xrtOVJnVzwtJBajqaFYl
	rTqXNpNkEZyl1w36VUGBhSVN64FqBVl5xC+BiIE/WelFAv/MLnxQnYmvLCtvllyz
	wPeq7GSitO10m4ds2o/PgvqPz32QYw41DJxvxLi0/+ICIXfHRRcCYsJ8WAJD0iqP
	XQqqwwWm0syh50ID+haOb+AKQyv37d9p3QLOI/2RMZfCVkjnXrtx/xRkFeYSSvAU
	G4OdIlznTg5MnWE/9CVpC2snBT9oHNRPnhNF+XKP+TraS5MpucciCsDjpFfem5aY
	6esuAmHFZ5zvZp2xexIKQ==
X-ME-Sender: <xms:IZr_aSYyVLr1lEdt-Gm2P8Gxt5Q5WQ8LbqazMtbn97_SErFV5BuAGg>
    <xme:IZr_aQNSfgXMzTn6gG142F1Pjx0xW6tmyv07wrpTz6h2NIShP56sB1JO9TRlZm9r8
    RKSHoJn71PbqJnxRjohUEMx_fvSHshPaxbZnCaxOaYr_hsYKW0rVrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopegrrhgusgdoghhithesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghruggssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhf
    rhgruggvrggurdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtoh
    eplhhinhhugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqrhgrihgusehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IZr_adXCKy0GpMA5JKBwLMRuse8SnWXWqhxlWF3Gt6zxQO0aATds2Q>
    <xmx:IZr_aSgIluwNYEA91ntGjHKaZylH6MZA_vG2GsolEDJDupm6GMWTWQ>
    <xmx:IZr_adqYlT3jL70lFcrV5NNAN478l2if8Dou0Ca-rSho7kEpeuC5yQ>
    <xmx:IZr_aQGnn6Yq0DOw06lTUl9FpRh8OlvfN7oAcCgolbErfkz3ymGGcw>
    <xmx:Ipr_aSth5EOCKrcaIGlIw60wUuOES_f8MxJr1yk8m8JSA3zISh7AJplW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A6FF41060065; Sat,  9 May 2026 16:33:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUyVbQhJqVtJ
Date: Sat, 09 May 2026 22:33:17 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Eric Biggers" <ebiggers@kernel.org>,
 "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-raid@vger.kernel.org, "Ard Biesheuvel" <ardb@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, "Russell King" <linux@armlinux.org.uk>
Message-Id: <75f5e8ce-e61b-4cca-ba8b-8ddf03310527@app.fastmail.com>
In-Reply-To: <20260509200503.GC11883@quark>
References: <20260422171655.3437334-10-ardb+git@google.com>
 <20260422171655.3437334-18-ardb+git@google.com>
 <20260509200503.GC11883@quark>
Subject: Re: [PATCH 8/8] ARM: Remove hacked-up asm/types.h header
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 328045015BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23888-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto,git];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid]
X-Rspamd-Action: no action

On Sat, May 9, 2026, at 22:05, Eric Biggers wrote:
> On Wed, Apr 22, 2026 at 07:17:04PM +0200, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>> 
>> ARM has a special version of asm/types.h which contains overrides for
>> certain #define's related to the C types used to back C99 types such as
>> uint32_t and uintptr_t.
>> 
>> This is only needed when pulling in system headers such as stdint.h
>> during the build, and this only happens when using NEON intrinsics,
>> for which there is now a dedicated header file.
>> 
>> So drop this header entirely, and revert to the asm-generic one.
>> 
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> This is actually a UAPI header.  I guess it got put there accidentally
> and isn't actually needed there?

Yes, commit ed79c9d34f4f ("ARM: put types.h in uapi") has some
explanations.

I can't think of any case where this would actually be used
from userland, and lots of ways it could cause trouble in
theory, even if it never has in practice.

      Arnd

