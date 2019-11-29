Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E983910D174
	for <lists+linux-crypto@lfdr.de>; Fri, 29 Nov 2019 07:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfK2G1i (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 29 Nov 2019 01:27:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53400 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfK2G1i (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 29 Nov 2019 01:27:38 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D7574142D4214;
        Thu, 28 Nov 2019 22:27:37 -0800 (PST)
Date:   Thu, 28 Nov 2019 22:27:35 -0800 (PST)
Message-Id: <20191128.222735.1430087391284485253.davem@davemloft.net>
To:     Jason@zx2c4.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1] net: WireGuard secure network tunnel
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191129033205.GA67257@zx2c4.com>
References: <20191127112643.441509-1-Jason@zx2c4.com>
        <20191128.133023.1503723038764717212.davem@davemloft.net>
        <20191129033205.GA67257@zx2c4.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Nov 2019 22:27:38 -0800 (PST)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 29 Nov 2019 04:32:05 +0100

> I'm not a huge fan of doing manual skb surgery either. The annoying
> thing here is that skb_gso_segment returns a list of skbs that's
> terminated by the last one's next pointer being NULL. I assume it's this
> way so that the GSO code doesn't have to pass a head around.

Sorry, I missed that this was processing a GSO list which doesn't use
double linked list semantics.

So ignore my feedback on this one :-)
