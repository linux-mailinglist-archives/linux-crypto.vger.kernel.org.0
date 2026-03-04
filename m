Return-Path: <linux-crypto+bounces-21562-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNFFC5Tnp2mDlgAAu9opvQ
	(envelope-from <linux-crypto+bounces-21562-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 04 Mar 2026 09:04:36 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E66B1FC21F
	for <lists+linux-crypto@lfdr.de>; Wed, 04 Mar 2026 09:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D324C311A4F7
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Mar 2026 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC8539901C;
	Wed,  4 Mar 2026 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAnpwVgv"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC4390227;
	Wed,  4 Mar 2026 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610594; cv=none; b=Sx2z0fjeu/yznP0QpFv2pTDPkPVB5K+7stYrmeSpIapJDwhAnZO02YpBRK9WRAdxBNw3R4cllyvKR9V8cI+P6kXkmuI8ctapgYHV1uivr14gGFLxcjC6eikh8IHXsFfus6NdTfVL4H7NPTP2vSx3ka3HRXiJHEuw+GtiqkOoyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610594; c=relaxed/simple;
	bh=zt8UewFBZPFmZ67GCtz9W90a/Rhp8LEbLJxHG4ez43k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fts9Wjiau5qy3uhnAdqspUcTt+36YIcjd4o+tXeXAqkDYueZIJKF8Q+Cv9g1hqLUSzLcjM0/5YwdSWWw6QKZcbN0PMdtwKZEn25d3wFS5ZeRayUx7EmL99vWt6UIz6hSSXBk4DasqS0dHfPlhlsxbgkIXu2bM6Gp43WmmA5przI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAnpwVgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43877C19423;
	Wed,  4 Mar 2026 07:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772610593;
	bh=zt8UewFBZPFmZ67GCtz9W90a/Rhp8LEbLJxHG4ez43k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAnpwVgvwlMdV8PZQsxUblMYk/Qqgh9JvpaIqSusEujNfRMiWCza7rWYMEUWchiqT
	 Xi4mxH+0U6HF0YScleuhLiiAeX/kbTwOwZmrQBjU4hs7dzgZq6O7TqdL3aydQ2ND+5
	 ecjpnT37HQBryhCweVys5Xk8R+uhcVDilEWB0MoQoLquGDWDB3NICWStnoJdYNTUq7
	 q2ZZvDGxNCn+84HNZ68sOMqg1qsKWcGQACwqwhx7fmbP0PIsVdSdvssG2RiDC82cBS
	 Rubhwah0mPp9GqtO9dCXxnFALx6AgrrFy4qmKiioPR2bkKTe6VN59LRWWGgKVS86v/
	 E52kGknhyDIjQ==
Date: Wed, 4 Mar 2026 08:49:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, atenart@kernel.org, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: crypto: inside-secure,safexcel: add
 compatible for MT7981
Message-ID: <20260304-uptight-mongrel-of-endurance-9567f7@quoll>
References: <20260303185451.70794-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303185451.70794-1-olek2@wp.pl>
X-Rspamd-Queue-Id: 8E66B1FC21F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21562-lists,linux-crypto=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[wp.pl];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wp.pl:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 07:53:49PM +0100, Aleksander Jan Bajkowski wrote:
> The MT7981 as well as the MT7986 have a built-in EIP-97 crypto accelerator.
> This commit adds a compatible string for MT7981.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


