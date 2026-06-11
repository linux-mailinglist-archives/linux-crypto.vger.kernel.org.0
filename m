Return-Path: <linux-crypto+bounces-25040-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pP1GBB5kKmqVogMAu9opvQ
	(envelope-from <linux-crypto+bounces-25040-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 09:30:38 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7560266F63F
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 09:30:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=fPBMBiDQ;
	dkim=pass header.d=redhat.com header.s=google header.b=Zp76OBJ5;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25040-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25040-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 494D730221D8
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C2364028;
	Thu, 11 Jun 2026 07:30:26 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F6362152
	for <linux-crypto@vger.kernel.org>; Thu, 11 Jun 2026 07:30:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163026; cv=none; b=JTmGfHoUGzbLxJ94R6LBrnsTVyFyekV4Mpe6e2jMFt4EZr0c+JEYvL9PUeBFx01PaEUftDWF58tEUobDroCPgEC/Qj/HEd2bQfGUS7zVDURTo/+owZyKIsFuDxyrJg3yw1GjB9MJ5qwZMc3IeOce5Mf0CwtYB/Tve7rpBXXqPVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163026; c=relaxed/simple;
	bh=42msgMb3P+btIm3Tjqc0kuZBe+w26HUqseSgoftktpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDYnzH6ScGt5Fz7lyjDN484nY/pO2fVu789EgTd3sAQN0WsiN2CM+pCm7ogXd8mTAF4e8FjCWQB+eLRi7QNdMODz59dXIIBLQy8C+/GPvmy8PYIe8UlNb2qVpZkFm2eSXHtMUDgvsoSGt1Qv+Kavtj04b34kRiQjCPMqG05vD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPBMBiDQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zp76OBJ5; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781163024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHOpC92ZLUKoaDH3aPL88/GHfZMM5nBt86vbyTmpcKE=;
	b=fPBMBiDQSIT7ejtPtX5KAKlopa5gNWyapcCBqB5S99p2rzFW2oXPnazuKrEbbgenQHqOjB
	b9BNJ8WhAV10beSOX4WSwJX3OoC2qe7PtU3GMrpZUPgO7cY6BUuxB+2GwBySMKeOvw5XId
	a8Ob34x3tauspT4Hdw30uq5nXvtPMvQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-EnY2q6G8PhaxzVjqaXO8zQ-1; Thu, 11 Jun 2026 03:30:22 -0400
X-MC-Unique: EnY2q6G8PhaxzVjqaXO8zQ-1
X-Mimecast-MFC-AGG-ID: EnY2q6G8PhaxzVjqaXO8zQ_1781163022
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46016bedbaaso3722483f8f.1
        for <linux-crypto@vger.kernel.org>; Thu, 11 Jun 2026 00:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781163022; x=1781767822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHOpC92ZLUKoaDH3aPL88/GHfZMM5nBt86vbyTmpcKE=;
        b=Zp76OBJ5NUD+C4YhbPL7OwX2M2SD4rLosky/UP0EIqnIjW2RDnboVKirHjL67abWtf
         t/z3ydYuUX12Hzi8N/CjyMQiU2dUO3J0mKdSWDXuBH7dSDLLzuE/IxJqQ+8soCE3SNnT
         qsyT05WvRpCbXqqxMoR2He00dHrSKOYZbaGhmffUGqM+7MPDJZYoR6TC2C5MaXk722iC
         WoDIW49Y5pxy+ys9Oh62O645k7fURRwCHpZequ2gfU4WPkhJB4RKQpm9TB6phCxeECpr
         4FxHDiLt+80gMnRZdBYR9hnSKfG6NwWc8ywkND8xFS1E1hLuBkJwzliRNpxgQp8Mimrj
         uIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781163022; x=1781767822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHOpC92ZLUKoaDH3aPL88/GHfZMM5nBt86vbyTmpcKE=;
        b=fs4kpiEr3Dx8aOk/Hk5w6Q2TVvBV75wmE70KInrD0MZHGHsiv9VjK1zOl28amdNk2a
         +kjsZnMuCxezU5/R67DMMuoUytn54Eh2Md6XF2V3S9RSrLlLRIt74i71lWBDYI9tZw2z
         DkHTn0/7xRZcbftZl/xx65T/65iJFhD79MGDlogGZhgsXB4lFL2XUZ9PyJmK9ANPa6wz
         n+LpH9uNjp8IULfa9rKaoeNXZzz4QbOCvcNl7Z1fsFP/JNsO29AabdifBbTPnbsxxWR0
         UrxFEFldO6MORQ5frZAJgd6f1d/8qF/5uvglhAlJhR1F+dkHRIA9KE1oKGJNyPy3ftxu
         DjJA==
X-Forwarded-Encrypted: i=1; AFNElJ9Drjo1R3fPpObscTPR95BwxKbUxhsOjigo+nXaiodaGdacrlFwVFsMTcif9ujjYkuznEnM4QDl9p8pCd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6coGBQ0LOUG5b+t07X/jO1kuholTozVLr9G63G/FifjGGqCjX
	ds2OD1xftNG85zWguvQBRBUPKqif75oSaan8pcUXC26wXKd17VmoGcvPk6zXC/aXj/Ya378KbSb
	bx3TEv23vj7h98+zIRohMyvJSXCPlhXiWBGMBbsEqBe9SgWfPOvuTK/+vsKfa68Mk7g==
X-Gm-Gg: Acq92OGTiHupeLQHilgUwGe+xL4OXZcH35Dq9bR73F4TqJEGXwc1mkAI7efMFKYqvO0
	QVngjILL3AfQgl/DFs37CL0yrYWaGO3a7/o/d2a8TOyuM8R8w7gHBnylHliP+ZeHazPx3rj2Arx
	kQ/tG5Atr+yWFIBCLPtQU4hN1LRW2BlA2SFelbuePgVeUJ7ed4lCOlBdDONHA+rhJwh86mc8nAi
	5D17xSOxgzv4PQrRFW8+7/TBTc3tY0Lti01mGXalMmr0l00GMYWVz6lz7pPysgVNDTXceJrYA9J
	zinmAaQwmCrVnuUNeksks7grG6iUybbHoyv48ntenUz8FJy45LkNLlb7EjF0TUmvcX5AKdhUUEu
	VX8WsZ4cfIQFEnPTSoCeIRdDY3icxw/fOPfjvBvnfFLZpr5dOlTq7+g==
X-Received: by 2002:a05:6000:220b:b0:460:1643:caf7 with SMTP id ffacd0b85a97d-460677acf24mr2526965f8f.27.1781163019836;
        Thu, 11 Jun 2026 00:30:19 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:460:1643:caf7 with SMTP id ffacd0b85a97d-460677acf24mr2526879f8f.27.1781163019248;
        Thu, 11 Jun 2026 00:30:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm62096991f8f.10.2026.06.11.00.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:30:18 -0700 (PDT)
Date: Thu, 11 Jun 2026 03:30:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, Kees Cook <kees@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, torvalds@linux-foundation.org,
	alan@linux.intel.com, tglx@linutronix.de
Subject: Re: [PATCH v3] hwrng: virtio: clamp device-reported used.len at
 copy_data()
Message-ID: <20260611025916-mutt-send-email-mst@kernel.org>
References: <20260531142251.2792061-1-michael.bommarito@gmail.com>
 <aio83ZWadVTiuNpR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aio83ZWadVTiuNpR@gondor.apana.org.au>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25040-lists,linux-crypto=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:michael.bommarito@gmail.com,m:olivia@selenic.com,m:linux-crypto@vger.kernel.org,m:jasowang@redhat.com,m:kees@kernel.org,m:borntraeger@linux.ibm.com,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:djbw@kernel.org,m:mingo@redhat.com,m:hpa@zytor.com,m:torvalds@linux-foundation.org,m:alan@linux.intel.com,m:tglx@linutronix.de,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,selenic.com,vger.kernel.org,redhat.com,kernel.org,linux.ibm.com,lists.linux.dev,zytor.com,linux-foundation.org,linux.intel.com,linutronix.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7560266F63F

On Thu, Jun 11, 2026 at 12:43:09PM +0800, Herbert Xu wrote:
> On Sun, May 31, 2026 at 10:22:51AM -0400, Michael Bommarito wrote:
> >
> > +	size = min_t(unsigned int, size, avail - vi->data_idx);
> > +	idx = array_index_nospec(vi->data_idx, sizeof(vi->data));
> > +	memcpy(buf, vi->data + idx, size);
> 
> I don't see how nospec can help here.  Please enlighten me.


All the "malicious device" things are confusing. Spectre things -
doubly so.

So if an access is speculated then CPU might speculate feeding a kernel
secret into RNG. And then the speculated RNG value maybe can be also
speculatively be used by some kernel code as an index
to trigger a cache access, finally leaking the secret?

Maybe?




> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


