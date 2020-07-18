Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27352247C3
	for <lists+linux-crypto@lfdr.de>; Sat, 18 Jul 2020 03:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgGRBdN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Jul 2020 21:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBdM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Jul 2020 21:33:12 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF8AC0619D2;
        Fri, 17 Jul 2020 18:33:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EFDB511E45910;
        Fri, 17 Jul 2020 18:33:11 -0700 (PDT)
Date:   Fri, 17 Jul 2020 18:33:11 -0700 (PDT)
Message-Id: <20200717.183311.1732891040563018960.davem@davemloft.net>
To:     rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: hash.h: drop duplicated word in a comment
From:   David Miller <davem@davemloft.net>
In-Reply-To: <83bdec97-38ef-f339-02ad-9066219b32c1@infradead.org>
References: <83bdec97-38ef-f339-02ad-9066219b32c1@infradead.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jul 2020 18:33:12 -0700 (PDT)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 17 Jul 2020 16:35:33 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled word "in" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: David S. Miller <davem@davemloft.net>
