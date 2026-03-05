Return-Path: <linux-crypto+bounces-21604-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA08J1I4qWnN3AAAu9opvQ
	(envelope-from <linux-crypto+bounces-21604-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 09:01:22 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656520D133
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 09:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A02C33086F0A
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Mar 2026 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16FC3451BA;
	Thu,  5 Mar 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaapHOgH"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C134321A
	for <linux-crypto@vger.kernel.org>; Thu,  5 Mar 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697567; cv=none; b=Q6IN1XdtOHMwuACwMOIfhRtSJ4nv//EZmHJe7oS1CIpFUlwRRP003wn+Z814SqPSSH3P/YcYpEMhHw8/oj0OMa1qxMhi8WSBUmsjxosbFJG452ZRW7CFHIieH1YbUh3+c/UPWkJczlWFB42+HmnlsoJHUoXILP13Yaoa9RdqTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697567; c=relaxed/simple;
	bh=71YnPh2B982zJlzw/VHHomXFsiXyIdqwFm/yK6xanj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViV9LVyqWRQHkH16Ot33FNNHo7OAGrmerplWPAA+Zuloh/f1ygM6CSTGmd95zOLvI8mcqhz9js+mdPdClnyytsRyjFi+peBvlWutc1kf8WpVMxvHUA8uhDqjV8B0aGD9/Oc+uTKCVHntiKHpJMT2HjP50jPcfhrL4m/hb+bckIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaapHOgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A159C19425;
	Thu,  5 Mar 2026 07:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772697567;
	bh=71YnPh2B982zJlzw/VHHomXFsiXyIdqwFm/yK6xanj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaapHOgH1C1wNTj7tOuyjB711VpX2b7N/Hejx1V5lAB64whXi+Xdj+vXtJc1Dpl2J
	 li+EHjFNDZKN0WiOEBB6GZ/FRjcbf6F9tAJy+o1KmvnSttyDznq46Bv2S5h1B61fgP
	 tHG4O6aTegj6Dw4eN+uaLzVbqu/uOjuI000R2LvZU25igo6RtXyrC0YT4n/7JusOG8
	 rqgWjQW51AD8C7OMCUYj3gheSqOIeQnHC8FypAJAgkAv3iP8z/tB2Yp8QP3oRYnk+N
	 +2Tz4+KWYOUVXrC+nUi9PpKgnF5LTwvZql8UcIgprrwbHMJnN3XoOpqOYzRQvzXmtT
	 kKCgQRdR6TaCg==
Date: Wed, 4 Mar 2026 23:58:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-crypto@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Subject: Re: [PATCH v3 3/5] crypto: pkcs7: allow pkcs7_digest() to be called
 from pkcs7_trust
Message-ID: <20260305075831.GB155793@sol>
References: <20260225211907.7368-1-James.Bottomley@HansenPartnership.com>
 <20260225211907.7368-4-James.Bottomley@HansenPartnership.com>
 <20260226203133.GB2273@sol>
 <bf8b8c374d4398a677b87246bb426c4cd157e1d0.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf8b8c374d4398a677b87246bb426c4cd157e1d0.camel@HansenPartnership.com>
X-Rspamd-Queue-Id: 0656520D133
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21604-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:50:10PM -0500, James Bottomley wrote:
> On Thu, 2026-02-26 at 12:31 -0800, Eric Biggers wrote:
> > On Wed, Feb 25, 2026 at 04:19:05PM -0500, James Bottomley wrote:
> > > +	/*
> > > +	 * if we're being called immediately after parse, the
> > > +	 * signature won't have a calculated digest yet, so
> > > calculate
> > > +	 * one.  This function returns immediately if a digest has
> > > +	 * already been calculated
> > > +	 */
> > > +	pkcs7_digest(pkcs7, sinfo);
> > 
> > pkcs7_digest() can fail, returning an error code and leaving sig->m
> > == NULL && sig->m_size == 0.  Here, the error is just being ignored.
> 
> That's right.  Basically I wasn't sure what to return on error
> (although -ENOKEY looks about right since it will cause retries on a
> different sig chain).
> 
> > Doesn't that then cause the signature verification to proceed against
> > an empty message, rather than anything related to the data provided?
> 
> Not if sig->m is NULL, no, because the verifier will try to reget the
> digest in that case (and error out if it fails).

Can you point to where that happens?  It still looks like it just
proceeds with an empty message.

I would think verifying the message is kind of the point, right?

- Eric

