Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B4114C5F
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Dec 2019 07:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLFGiP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Dec 2019 01:38:15 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52970 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfLFGiP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Dec 2019 01:38:15 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1id7Fl-0005Nu-Ve; Fri, 06 Dec 2019 14:38:14 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1id7Fk-00050K-RT; Fri, 06 Dec 2019 14:38:12 +0800
Date:   Fri, 6 Dec 2019 14:38:12 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH 0/4] crypto: api - Retain grabbed refcount until registration
Message-ID: <20191206063812.ueudgjfwzri5ekpr@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When an instance grabs an algorithm, it has to hold a reference count
on it until the instance is registered.  This is because otherwise
the algorithm can go away at any time.

A number of such bugs has been fixed in the past.  This patch series
tries to close the remaining holes.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
