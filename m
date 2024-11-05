Return-Path: <linux-crypto+bounces-7901-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1B79BCE21
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Nov 2024 14:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DF41C216FE
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Nov 2024 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE6E1D5ACE;
	Tue,  5 Nov 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="n0sXTzpi"
X-Original-To: linux-crypto@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D31D6DBB
	for <linux-crypto@vger.kernel.org>; Tue,  5 Nov 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813967; cv=none; b=Jx0w8sXeAIjl9gt3Csjc7Jnov4aZru+Q5QM67USZNa5+Xccmkp9qElotUbNtO/m064F+n2SF+A87d4yACjalYgfiysI/AZXzVmLTL+uxaGERjbffAOTA73ur3rTmaVWat89zcpIlhiQSsi7Uu89mL9mPWvoqOnnJyoL+albO2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813967; c=relaxed/simple;
	bh=9DJp7J0hyfRnz5ccj5zCZy+dzq4cjMmMG/w5+bn1Fog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBRXSYAO8fxK3rbkhSg5AsTbB1Tx8suGH6Z9TcbeNb43I8guvTN+cZ40YNfBLnD6fyijNzVLmCsmKI1/RrX7ruoNyIy1Bs9opuvRmOXOkx9zE86/dEVwVct2EXsL+TRsPrsdtrMRuORBnsDXxKvUfLwBdPYmYkmGdl3F4mhmWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=n0sXTzpi; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A5Dccb4012098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 08:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730813921; bh=KYeCLSsUZRIrmEOMwxGqSfD7V2RsNkns3qvfU6C43UA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=n0sXTzpicMGl6JI0ADkVc/HiKPojEgkGYyO1pQx2dzcrnqvXsM2RZzo+Sb5svGPgc
	 qW0SX7zl5zqRkKltYfBmUgFXDCqUkRisSud/xR5J6Tbouah7IfPO5+X+s+0mFZ/id0
	 KJJ0kAX4lfNE8lrvU3EBvRFI9YhbvsP4WOsZDJiCLfWkjotYwy29Ajn/HIKkTf9yE5
	 NEeFKTWS8cZ06m1TRDAbI0VH51oFtGnGm3lMEoaaiG94ccor1fss0Fcwy+3maWrH6L
	 KfqzubfM08EeL0DYjOq/Yn2j7aagvnHNL3UgvZEC8cQqhZOWSOz17Mgc3iRw2QINym
	 fJUtJFR76A04Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7ED14340E22; Sat, 02 Nov 2024 15:26:35 -0700 (PDT)
Date: Sat, 2 Nov 2024 15:26:35 -0700
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 15/18] ext4: switch to using the crc32c library
Message-ID: <20241102222635.GB455688@mit.edu>
References: <20241025191454.72616-1-ebiggers@kernel.org>
 <20241025191454.72616-16-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025191454.72616-16-ebiggers@kernel.org>

On Fri, Oct 25, 2024 at 12:14:51PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32c().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Theodore Ts'o <tytso@mit.edu>

