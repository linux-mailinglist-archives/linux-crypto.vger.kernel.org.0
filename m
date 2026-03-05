Return-Path: <linux-crypto+bounces-21626-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BU7JC3aqWneGQEAu9opvQ
	(envelope-from <linux-crypto+bounces-21626-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 20:31:57 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA92217902
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 20:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E367304482F
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Mar 2026 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739753DFC63;
	Thu,  5 Mar 2026 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUfeNTTr"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3EB3D5232;
	Thu,  5 Mar 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739112; cv=none; b=A8BTcBtkWYoSwCdSxLbU8Awr+PxfGse9iuTIp98rIEaho4kH10VOW0u7R/szyCoeVEFUKTnGAmZsIkur211e0Us+9bakN+bESWRGexSkr3hP3C8AfGYakP9WnJIOvbzKDUk9kgM+XW2+9gXedmxe2evPLDStfoVHTOkSJQujLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739112; c=relaxed/simple;
	bh=jiH3cPo01fWhlFeVyhSM+sERjE9JFWIPvuBM/2lEIvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzKkA5rQ+492+wFsC3vT2B2WR6WV+80JEdYNKFO+KrQJjJYnDGHwhm6evz4JZ66+Js+J2vjQo+dOU8D+TRI3kRd3DLI3fVOtpP8imhjJddKluViy8xdcj67dwK7gS5+wOwE+zZsemy6FfQeTZ9l+T6jia4rdp+7MnvAC9vw6aYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUfeNTTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907FCC116C6;
	Thu,  5 Mar 2026 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772739112;
	bh=jiH3cPo01fWhlFeVyhSM+sERjE9JFWIPvuBM/2lEIvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUfeNTTrgvv4qxRcxJhMGTT2RE8xIq3C9hocWsyhnSD3lk0r//nJVHVlmtU3t80m/
	 71/yZOiF37x+dmie0YaOBZPIQUtIulfFyLevxKD69agNwtRfckvCGU8C7tyETFyQbl
	 CICXvpVfykoXUg5S/HP/dZf9DX4s6oq63NT6ld1TBX+bybTvsyp/fGcFOl+apUO9lK
	 Hv10VoPmjubMgU7a2Bx3GZVJ9s414wqDLGtY76H5iEtyUI61/XDsXoZk7/tUWKEckq
	 lHZsKs633G3WAUCL7R2gASGCBEV4q/z+p3ahxWmWjoZ5rfdjq+tgx474QJcmKchfib
	 UbmB7A28C0mFA==
Date: Thu, 5 Mar 2026 11:31:50 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 00/21] nvme-auth: use crypto library for HMAC and hashing
Message-ID: <20260305193150.GF2796@quark>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260304132327.GA15515@lst.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132327.GA15515@lst.de>
X-Rspamd-Queue-Id: DCA92217902
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21626-lists,linux-crypto=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 02:23:27PM +0100, Christoph Hellwig wrote:
> Thanks, this looks really great:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> 

Thanks.  I assume Keith will pick this series up for 7.1.  Keith, I
forgot to include you explicitly on the recipients list (I must have run
get_maintainer on drivers/nvme/target/ instead of drivers/nvme/common/),
but I assume you received this series via linux-nvme anyway.

- Eric

