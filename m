Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D584C285757
	for <lists+linux-crypto@lfdr.de>; Wed,  7 Oct 2020 05:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgJGDvA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Oct 2020 23:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgJGDvA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Oct 2020 23:51:00 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B80208C7;
        Wed,  7 Oct 2020 03:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602042660;
        bh=RNFodyO24BpIYXMrNPDq0InBAX11+JUBpdE1Nim3iJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/e1efedoOwMs+LURnzwzScfizgJh3uoQpwBocHnobgAobqORxiE7dlwgC2C9h4Nr
         eBvn75vENJdCb2ij44b/0U7hq0Pkq/CyCW30DV0h/w9cnMts6t0mzD1zT7ndt4OhQz
         gyKZtOKd01rDK+s6AoE/i4aP0B8fTa5mMbg4QDj0=
Date:   Tue, 6 Oct 2020 20:50:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] random: remove dead code left over from blocking pool
Message-ID: <20201007035058.GC912@sol.localdomain>
References: <20200916043652.96640-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916043652.96640-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 15, 2020 at 09:36:52PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Remove some dead code that was left over following commit 90ea1c6436d2
> ("random: remove the blocking pool").
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Ping?
