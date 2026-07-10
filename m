Return-Path: <linux-crypto+bounces-25829-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3PS9G2EyUWqQAgMAu9opvQ
	(envelope-from <linux-crypto+bounces-25829-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 19:56:49 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD7573D22F
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 19:56:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eWHz92+h;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25829-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25829-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E6C7301091D
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C83793CC;
	Fri, 10 Jul 2026 17:56:46 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E8374735
	for <linux-crypto@vger.kernel.org>; Fri, 10 Jul 2026 17:56:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706206; cv=none; b=Zj94IniXKCTjAYqf75nEJQxwLOFVBz5fbz9CNk+N6UgtytIs7sCx8IjScTFEwQ8nnfCQb5j64GzD+QPATY3s+Sxkpi5uZ/Nx8sD2WawoSVBC/mcjqBaGY4TWz7m2mwrSvlk1448TE+TO2HbKKINGZC1pJImXfGcobWdWqeuvSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706206; c=relaxed/simple;
	bh=jADYyqFygto5enpfNC+CidkpY0yS3r13Fz818jv94OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcZnabtgLeITSUhHZtarxiOHTlxXi5pNLejShKzhHDcBayhUX+VPimlZgURJ39Ti0mP6jeyJu09gQtw5faqgmezYJn6ZbP9PzJG9Ln3Qr7Km73w6/IYixt5RPHdogCHNIn6eMyGKgH1kW9AhBq4oJ+3a+b5RiJqhzR1lenZcTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWHz92+h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F5E1F000E9
	for <linux-crypto@vger.kernel.org>; Fri, 10 Jul 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783706205;
	bh=ohhHy5uM0BVFQV/nNssiB/d3H/GEb9yqQS/GAiFhZUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eWHz92+hhvETH9yEvLYkZ/h20XBEDr7hqkPjOxm8+Dsi2IUem97d4KrmYAwYEPZhw
	 DrJ9QcScNP7OiZN742U/aUoWExu0FPXh0dA70aI4AKnSPTUcxuVhUky8DNzFl0tD+U
	 otEMP8Tp37C0Z5vZsuzzz2x6FMjpREw3z/eyZQ2yF0SbEbh2EAOJqxWvJ1vITYXw13
	 mHyPqdEGpFYKY5vCj4nKtNiMVqsC/wX/iMoLiLVs1HhxhKXd0DR0eR0khMu+2JLgMF
	 2jTv/6uDj8TFdb4J0CvmiE72mHg53nXP3ZRP78zQ0VF4uIY19QjqDRey0omF4gkVll
	 qiGQs2AEKqrrw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso1086124e87.3
        for <linux-crypto@vger.kernel.org>; Fri, 10 Jul 2026 10:56:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr3U8/PRwyT/mi2fzQ1epz1lD25A64QIDnlwcIKcUJilYe+pO9SqvqlwwIIldnIdudSyMofiQiGn9Em0m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjde6UaS1h+LdR8zgLjgz630UybQESM4wL+aCFNpF+x9Vhji2
	mFLgdwKAynRmp6Y+75NEKhMVGwYIyfIy/N89AbO52FGmAp2CJbT1jXptmR9/1ctJE3ySpI+D7TH
	8ZngWWNi31YsJKq94nuHehWYiyfc+Rlg=
X-Received: by 2002:a05:6512:40c4:20b0:5ae:c454:3740 with SMTP id
 2adb3069b0e04-5b0236ec2f0mr21748e87.60.1783706204298; Fri, 10 Jul 2026
 10:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704121524.42229-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260704121524.42229-1-pengpeng@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 19:56:31 +0200
X-Gmail-Original-Message-ID: <CAD++jLkddRr5WwLGmf1XnO+hS16ss3ePVedC0GXcPWs+Hq6A5Q@mail.gmail.com>
X-Gm-Features: AUfX_myjzJ7OaZTkgOU1pIQclIKeQe3hhnCAquIhA8MZ1Ke5dbwipiXG6jzcPLA
Message-ID: <CAD++jLkddRr5WwLGmf1XnO+hS16ss3ePVedC0GXcPWs+Hq6A5Q@mail.gmail.com>
Subject: Re: [PATCH] crypto: ixp4xx: add missing MODULE_DEVICE_TABLE()
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Imre Kaloz <kaloz@openwrt.org>, Corentin Labbe <clabbe@baylibre.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25829-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:kaloz@openwrt.org,m:clabbe@baylibre.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-arm-kernel@lists.infradead.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBD7573D22F

On Sat, Jul 4, 2026 at 2:15=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn> =
wrote:

> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
>
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
>
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

