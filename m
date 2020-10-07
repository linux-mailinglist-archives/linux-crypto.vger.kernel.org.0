Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17468285764
	for <lists+linux-crypto@lfdr.de>; Wed,  7 Oct 2020 05:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgJGDvr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Oct 2020 23:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgJGDvr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Oct 2020 23:51:47 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26213208C7;
        Wed,  7 Oct 2020 03:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602042707;
        bh=X/E36DMWc4gd06k/fpO6MR3SxuEvjok10UFdPcu5ROo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dwVyyP65YZ0tuCfwa+o3HcFK6LGC24IW9BajYFcqTP+nyAbYp1lybCJR+A2c5g4l9
         1JESCeLDqRFZkH+vaNBaQQG69YHo0sqFDHenBgzXB5h6/r+btpiub4xS36kh94NfKP
         G/64KRN5ERH8nqtLGE7TpFMt1uA8G5IVB37QJsBs=
Date:   Tue, 6 Oct 2020 20:51:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: initialize ChaCha20 constants with correct
 endianness
Message-ID: <20201007035145.GD912@sol.localdomain>
References: <20200916045013.142179-1-ebiggers@kernel.org>
 <20200918204207.GC80112@mit.edu>
 <20200918215705.GA126697@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918215705.GA126697@gmail.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 18, 2020 at 02:57:05PM -0700, Eric Biggers wrote:
> On Fri, Sep 18, 2020 at 04:42:07PM -0400, Theodore Y. Ts'o wrote:

Ted, any further feedback on this?  Are you planning to apply this patch?

- Eric
