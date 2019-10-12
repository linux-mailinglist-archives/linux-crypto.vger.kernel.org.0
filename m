Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E129D4D1D
	for <lists+linux-crypto@lfdr.de>; Sat, 12 Oct 2019 07:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfJLFM7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 12 Oct 2019 01:12:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55688 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfJLFM7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 12 Oct 2019 01:12:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B8D9615008C66;
        Fri, 11 Oct 2019 22:12:58 -0700 (PDT)
Date:   Fri, 11 Oct 2019 22:12:53 -0700 (PDT)
Message-Id: <20191011.221253.1698497015931303703.davem@davemloft.net>
To:     ebiggers@kernel.org
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [RFT PATCH 0/3] crypto: sparc - convert to skcipher API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191012043850.340957-1-ebiggers@kernel.org>
References: <20191012043850.340957-1-ebiggers@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 11 Oct 2019 22:12:58 -0700 (PDT)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 11 Oct 2019 21:38:47 -0700

> I've compiled this patchset, and the conversion is very similar to that
> which has been done for many other crypto drivers.  But I don't have the
> hardware to test it, nor are SPARC64 crypto opcodes supported by QEMU.
> So I really need someone with the hardware to test it.  You can do so by
> setting:

Eric, I'll try to test this for you over the weekend.
