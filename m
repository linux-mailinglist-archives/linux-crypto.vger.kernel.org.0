Return-Path: <linux-crypto+bounces-21063-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ChaUErXbm2n98QMAu9opvQ
	(envelope-from <linux-crypto+bounces-21063-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Feb 2026 05:46:45 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF24171CBD
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Feb 2026 05:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB8E6301E6EE
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Feb 2026 04:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244AA8248B;
	Mon, 23 Feb 2026 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRFOf6d8"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1D125A9
	for <linux-crypto@vger.kernel.org>; Mon, 23 Feb 2026 04:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771822001; cv=none; b=QR6mJIt3sZOaQrqsO62w5tAi/u75qbWpWgkK7NWQ2gvny0iPJNP4YMN3+ac9/8wGD6SPmZpWPLVMjJjDmxV5AixOVOg2FBRYPyLu5gQ+b+QV1O7nep3oaJQM7AKfXXppBfWkvTjQLkB7HhhNuWcwnvkFpn32KGscs4uAe3rxk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771822001; c=relaxed/simple;
	bh=z6EgHj0RhN0MwewS0wFDPuOmfnSGCGIMiPjxDhbbsog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVC5v0RHVb8mvbR4Ro9VYY2Z20DRO78kgvM41QWaZM9iJtTFNCqNIzcVzUFzixnfaVCcnjSUf5tfFHQuBgcldue8V8Nnjp/1+gsavktCxDFo8877BodbU1en9JDMh7q4P5SdYtpM1eIjQYqiJIZ/sPtm20YTzjNZBBGfkNIhOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRFOf6d8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226C4C116C6;
	Mon, 23 Feb 2026 04:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771822001;
	bh=z6EgHj0RhN0MwewS0wFDPuOmfnSGCGIMiPjxDhbbsog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dRFOf6d8Jllc9NUW9qrWOjYwZLF8ppJCMGCYVp/muRjUgkqVK0KMZjeG7VyZZfZ11
	 HAxMj0qkM2eNVzsr7x27lUuqLbLWUvieWkGO6aRTi0KhJk8J9WOXnWS+RVnhRIurA5
	 INkc0ay+Wv0cJYRims1ZQv0NuQgp2QzkuzoQ0wlM7poUeOekk6v7qaUS0W/UAHvGWS
	 Bl4hP15mwm61b43XCr5BC2O6+K2iKDkhy+1YKHTYJy6uztjyokgUbwmU276gv/wrHp
	 /Fo4DJySzWuoiJg9WX3UJI8F5hOg9pMdhF0WdqhQXoH3gmn0ES5zD84hLOod2zAkS5
	 mUiF6TJm6Yd2A==
Date: Sun, 22 Feb 2026 20:45:51 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Manas Ghandat <ghandatmanas@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	herbert@gondor.apana.org.au, rakshitawasthi17@gmail.com,
	security@kernel.org, linux-crypto@vger.kernel.org
Subject: Re: Null deref in scatterwalk_pagedone
Message-ID: <20260223044551.GA58799@sol>
References: <e3044be2-1f05-4cfb-99e4-39dc09e4aeb4@gmail.com>
 <63fdfca0-5165-4307-ae8e-c25cbed7f8cb@gmail.com>
 <20260222202123.GA37806@quark>
 <1205234f-6ddd-4369-834c-6415f8fe0265@gmail.com>
 <2026022305-handoff-maverick-13c5@gregkh>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022305-handoff-maverick-13c5@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,davemloft.net,gondor.apana.org.au,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21063-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8BF24171CBD
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 05:14:05AM +0100, Greg KH wrote:
> On Mon, Feb 23, 2026 at 09:32:17AM +0530, Manas Ghandat wrote:
> > On 2/23/26 01:51, Eric Biggers wrote:
> > > What kernel feature are you using that does GCM encryption?  E.g.,
> > > IPsec, TLS, SMB, ...  Is the code in-tree?
> > 
> > I was fuzzing the TLS subsystem when I found the crash. And yes the code is in-tree.

Okay, the issue is very likely there then.  Once you find a reproducer,
you'll need to report it to the maintainers of net/tls/.

- Eric

