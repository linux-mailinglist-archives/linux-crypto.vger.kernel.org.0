Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1511C1FCA
	for <lists+linux-crypto@lfdr.de>; Fri,  1 May 2020 23:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgEAVkd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 1 May 2020 17:40:33 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:35255 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAVkd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 1 May 2020 17:40:33 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ebce33ea;
        Fri, 1 May 2020 21:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=mfANb4NLGTbGs+1tPQehX2mYl+M=; b=ykPh+dJ
        QDLWKaw2Uecg3ANW27v3xaMCzgsHcOIduNrQbo+NghqTyQWGe7nWl6C2ouuqocEh
        Uw2DKmDQJq7Uguh6cMrugK2p8mFNB5JFllYegFR3ydaOyPZYOOjZkTHUALQF6YxB
        3hvi3TvNe48hBTG4p+h+Vc2JJLPuUSNJEwtWscqrnXnU0cxv8kYcY6uvC6KpHFSf
        57yJNe98ssuT7BdWh/D7yKfga/ycaR2SjmA6W0sk5+aTfceSgNpPg85/FIAuFBU1
        +lyDhNhcr/Rt8FmKS6+oozcma9h4ecRDw5ZgaOihsumPAUgsghIiolLc+SCc+qA8
        a2YmQRV2leV/42g==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 76a5f6fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 1 May 2020 21:28:27 +0000 (UTC)
Date:   Fri, 1 May 2020 15:40:30 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] crypto: lib/sha256 - return void
Message-ID: <20200501214030.GA522402@zx2c4.com>
References: <20200501164229.24952-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501164229.24952-1-ebiggers@kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, May 01, 2020 at 09:42:29AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The SHA-256 / SHA-224 library functions can't fail, so remove the
> useless return value.

Looks good to me, and also matches the signatures of the blake2s library
functions, which return null.

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
