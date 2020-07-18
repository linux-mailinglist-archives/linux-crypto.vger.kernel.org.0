Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A132247C5
	for <lists+linux-crypto@lfdr.de>; Sat, 18 Jul 2020 03:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgGRBdV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Jul 2020 21:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBdV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Jul 2020 21:33:21 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9ACC0619D2;
        Fri, 17 Jul 2020 18:33:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F36D811E45913;
        Fri, 17 Jul 2020 18:33:20 -0700 (PDT)
Date:   Fri, 17 Jul 2020 18:33:20 -0700 (PDT)
Message-Id: <20200717.183320.1633055686847661258.davem@davemloft.net>
To:     rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH] crypto: skcipher.h: drop duplicated word in kernel-doc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c031a64c-2337-cd9d-e148-ed8365c2365e@infradead.org>
References: <c031a64c-2337-cd9d-e148-ed8365c2365e@infradead.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jul 2020 18:33:21 -0700 (PDT)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 17 Jul 2020 16:35:49 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled word "request" in a kernel-doc comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: David S. Miller <davem@davemloft.net>
