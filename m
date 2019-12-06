Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91CD114AF0
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Dec 2019 03:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfLFCfa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Dec 2019 21:35:30 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37546 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfLFCf3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Dec 2019 21:35:29 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1id3Sq-00033M-NQ; Fri, 06 Dec 2019 10:35:28 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1id3Sp-00077A-Cj; Fri, 06 Dec 2019 10:35:27 +0800
Date:   Fri, 6 Dec 2019 10:35:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH 0/3] crypto: shash - Enforce descsize limit in init_tfm
Message-ID: <20191206023527.k4kxngcsb7rpq2rz@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

As it stands we only enforce descsize limits when an algorithm is
registered.  However, as descsize is dynamic and may be set at
init_tfm time this is not enough.  This is why hmac has its own
descsize check.

This series adds descsize limit enforcement at init_tfm time so
that the API takes over the responsibility of checking descsize
after the algorithm's init_tfm has completed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
