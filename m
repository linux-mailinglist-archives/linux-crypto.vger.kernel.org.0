Return-Path: <linux-crypto+bounces-22059-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLXbD++CuWmxHAIAu9opvQ
	(envelope-from <linux-crypto+bounces-22059-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 17:35:59 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD812AE17E
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 17:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D5F311510D
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC9375F81;
	Tue, 17 Mar 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkpGq4f+"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B232222AA;
	Tue, 17 Mar 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765097; cv=none; b=HHQ/dhUadO2EAFZa98JkQ4SQa3zogTeLvC2NoQS31RALKbq+N+EMI0fQ/Mth+59wMzJ7uiMSjoJ576EQV7rDhs7Tllc+NWicj5iJehEu8IxU6ekx3+NZrDyAWKOEhPMahqrpN9IPETOZEeTGabT6zDWJ/W8BehblYolYkp1YdHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765097; c=relaxed/simple;
	bh=8/FJNnkPO/0g2ymP6/7fbTeBmVZw+yAtGLxHmbLn+io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTRzsgTgmf00c0wr8r9q7Qetk+CYuYIVeQ2drWbbszyDR1u5KULfRLNXSOfQH17AFtIPuuQ1nmu1y9qx5xTrIVLnUPHYBI/qR7L01dZSOa7xqF4kcCOhh+1Nvt7BcwDeoCNlaUWEpOoeZlhzgzrpNH9/GkXrmREpyqkOe7aF0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkpGq4f+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BB7C4CEF7;
	Tue, 17 Mar 2026 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765096;
	bh=8/FJNnkPO/0g2ymP6/7fbTeBmVZw+yAtGLxHmbLn+io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkpGq4f+UeN57kUA3foH32ltuqqh+l1uEq1RsrJJLtApBgoioFe4pw5gvUcnaheiI
	 t39dP9J0UaOcdrAMnEo9qqQBI4oPjtRoEzKPVKIa8WFPOKAB8mgjbdkRRrQ14W2usr
	 UEvuP4mxw4nfoP/EbMtwIHOCoSu1xUOXNB3JYwRc3JIReo9KmOHuHoj3W1+46EoraB
	 Ze+I5gODti361OEhay3TKdULx2j9BZOk+kHRWQRRHxKH0MMZo3FSTLqg7cGmXdp/lR
	 T3ydZpw1GW0JvFx/yfRXxzc84uk28nvt7eoioY9ROQHey778mgZsDYGng5zOmMUC4T
	 pwZCVo0f6T+6g==
Date: Tue, 17 Mar 2026 09:30:37 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] crypto: crc32c - Remove another outdated comment
Message-ID: <20260317163037.GD2931@sol>
References: <20260316205659.17936-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316205659.17936-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22059-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBD812AE17E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 01:56:59PM -0700, Eric Biggers wrote:
> This code just calls crc32c(), which has a number of different
> implementations, not just the byte-at-a-time table-based one.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is targeting crc-next

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next

- Eric

