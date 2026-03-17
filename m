Return-Path: <linux-crypto+bounces-22020-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC7CJrk2uWmcvAEAu9opvQ
	(envelope-from <linux-crypto+bounces-22020-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 12:10:49 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB22A882E
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 12:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96A293026B46
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B93A7F5D;
	Tue, 17 Mar 2026 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv0yuRI4"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5235DA6B
	for <linux-crypto@vger.kernel.org>; Tue, 17 Mar 2026 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745841; cv=none; b=Y7YmmxV7UbNPFczaXN1/zJ5N+Qq4jW6Bqra7VVB4XWP2eUjf3GOcG29a/T6jWgJgMZoEgxHYuRbyIPVwLFpz6tqbQQwRJEH0MHkbZiS2j5SsOMm+mN3B7nv0PPOVAg4Arw/NoH7idq/zHy/o3iIjPZGeGzMbCK0lYGIGO+om2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745841; c=relaxed/simple;
	bh=3bEvfE0pUL8utFtiZuNftijKZptJwtJvC/QbKkBlwXs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AvGNgnfaY9Ad/2HOaonb5eMWESUTEU0N2xk37q9GOkdvk/5RD1qkcPQbLsTD8NfpDZWIVjaqsMlJGJq8YITUV4akxDUK8Z1RfIU+djWIMVwc3fkc3lTOnsJY8p/U1BwQH9oSWuz4qKV24uFkqfQ1nXSERpgn+3phkbULYoEZGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv0yuRI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE52C4CEF7;
	Tue, 17 Mar 2026 11:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773745841;
	bh=3bEvfE0pUL8utFtiZuNftijKZptJwtJvC/QbKkBlwXs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sv0yuRI4zbij3xC7pH9F700V4EzPolTrOdP6boH6srOxTnx81+HGEIPpHELXp2WXn
	 q4W0kZpwopsA+enyjWji1lneiDmCpeq+EyGfbRI5xQDJlO4kb8Sm24DBqpjZ4xc2qe
	 YVx+TIrlTNFzUYCeJBhQNWH0YdwzX7l63xvNp6LO2mZntjFkdU675VibLdNEDkg7I3
	 m2TuRZ0BrDsQ7BRETH9Yb0Mnez1hUNHkAVtXYtSSNoFOwVpzOGZLnoBhstXs/4wwyK
	 dOzpA5rK356/bjXoKWH1S6L9Njb1zQFrhR/+2jXkzE5J/EcOYOlQU2rfgaJFMqIGEu
	 sAMkcUtGrshhg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0508DF40069;
	Tue, 17 Mar 2026 07:10:40 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 07:10:40 -0400
X-ME-Sender: <xms:rza5aU7vWiy4SKtw3-K_dcso1cFwCUJoRnGyxh7Nx5y6MD7aV0n0xQ>
    <xme:rza5aQvMLrHjqSBB8heGziWd1KEYaLb5NfXFQO9LG8JmEGiEQo1lhWEqsB5fCXUqO
    BIq4cmYofaJnwzC5G38GFHJVirffXSUm_oSphEV7ZLKc243mYxjzAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpth
    htohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    phhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    grshhonhesiiigvdgtgedrtghomh
X-ME-Proxy: <xmx:rza5aSignthvd7zBT0pYbkHlMT2EeXrTF_RFOpYEIrG_Na8x7gtMFA>
    <xmx:rza5adGAm2YbVeb_z-iCEYhdalcRo2ABxseXOUUgfP0_PNzHdOl_Ow>
    <xmx:rza5aZ_6d9gVCwDSZX4u3e8S9SWimrwKVrarpZGIS5rBfvw2LoDmKw>
    <xmx:rza5acyKPXFPLlCSAJfAl1oJb0BP8V9O_Ja4kuGyf59d-Blqe72Fnw>
    <xmx:sDa5adMehPG5DebFbi0PmTR7LtoWV7MQSSibmr7I7GIXzdq_SR6E74tx>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D8E01700065; Tue, 17 Mar 2026 07:10:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ao4qWWs5d1pR
Date: Tue, 17 Mar 2026 12:10:19 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, linuxppc-dev@lists.ozlabs.org
Message-Id: <6956f2d9-dd9a-404a-a6e6-1d5478a1410a@app.fastmail.com>
In-Reply-To: <20260317044925.104184-1-ebiggers@kernel.org>
References: <20260317044925.104184-1-ebiggers@kernel.org>
Subject: Re: [PATCH] lib/crypto: powerpc: Add powerpc/aesp8-ppc.S to clean-files
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22020-lists,linux-crypto=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 58CB22A882E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, 17 Mar 2026, at 05:49, Eric Biggers wrote:
> Make the generated file powerpc/aesp8-ppc.S be removed by 'make clean'.
>
> Fixes: 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized 
> code into library")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  lib/crypto/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 725eef05b758..dc7a56f7287d 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -53,10 +53,13 @@ endif # CONFIG_PPC
>  libaes-$(CONFIG_RISCV) += riscv/aes-riscv64-zvkned.o
>  libaes-$(CONFIG_SPARC) += sparc/aes_asm.o
>  libaes-$(CONFIG_X86) += x86/aes-aesni.o
>  endif # CONFIG_CRYPTO_LIB_AES_ARCH
> 
> +# clean-files must be defined unconditionally
> +clean-files += powerpc/aesp8-ppc.S
> +
>  
> ################################################################################
> 
>  obj-$(CONFIG_CRYPTO_LIB_AESCFB)			+= libaescfb.o
>  libaescfb-y					:= aescfb.o
> 
>
> base-commit: ebba09f198078b7a2565004104ef762d1148e7f0
> -- 
> 2.53.0

