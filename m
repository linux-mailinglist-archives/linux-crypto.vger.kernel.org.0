Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD13115D20
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Dec 2019 15:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfLGOPD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 7 Dec 2019 09:15:03 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54242 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfLGOPD (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 7 Dec 2019 09:15:03 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1idarO-0007w5-HW; Sat, 07 Dec 2019 22:15:02 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1idarN-0002ps-Dh; Sat, 07 Dec 2019 22:15:01 +0800
Date:   Sat, 7 Dec 2019 22:15:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [v2 PATCH 0/2] crypto: api - Fix spawn races
Message-ID: <20191207141501.ims4xdv46ltykbwy@gondor.apana.org.au>
References: <20191206143914.hfggirmmnjk27kx4@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206143914.hfggirmmnjk27kx4@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch series fixes a couple of race conditions in the spawn
code.

v2 fixes a crash in crypto_more_spawns.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
