Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB83F490
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Apr 2019 12:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfD3Kwa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Apr 2019 06:52:30 -0400
Received: from mail.nic.cz ([217.31.204.67]:44098 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbfD3Kwa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Apr 2019 06:52:30 -0400
Received: from localhost (unknown [172.20.6.125])
        by mail.nic.cz (Postfix) with ESMTPS id 4483163521;
        Tue, 30 Apr 2019 12:52:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1556621549; bh=Lg34VrA1BSEXC2Dz6PUPqjMVznXI19kbne+iw1TwpEQ=;
        h=Date:From:To;
        b=GN1jCqow156VzkhT+7irld6o6GBce+cHPgkQNQYS/MCvQQSPZjuu/zyBToZpZxS7M
         s2Oy6TVzPpXX+ehD9oQ9jIgS4YIEGIsudcLBM8YGgsRDcl73PezDJ/UJJqagEmUkSR
         KcrVMj7WohZUughPUuKNfIGTqvTNzXqvqaNbyeSM=
Date:   Tue, 30 Apr 2019 12:52:28 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Andrzej Zaborowski <andrew.zaborowski@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: crypto: akcipher: userspace API?
Message-ID: <20190430125228.4b0deae6@nic.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello,

I would like to ask what is the current status of the userspace
akcipher crypto API.

The last patches I found are from 2017
https://marc.info/?t=150234726200004&r=1&w=2 and were not applied.

Marek
