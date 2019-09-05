Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA78A9C1E
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Sep 2019 09:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfIEHmD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Sep 2019 03:42:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41633 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfIEHmD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Sep 2019 03:42:03 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i5mOu-0008Ju-VZ; Thu, 05 Sep 2019 09:41:53 +0200
Date:   Thu, 5 Sep 2019 09:41:52 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-crypto@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Keerthy <j-keerthy@ti.com>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] random: Support freezable kthreads in
 add_hwgenerator_randomness()
Message-ID: <20190905074152.3oufn7yqr4flu3yc@linutronix.de>
References: <20190904110038.2bx25byitrejlteu@flow>
 <5d700756.1c69fb81.77c08.9c82@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d700756.1c69fb81.77c08.9c82@mx.google.com>
User-Agent: NeoMutt/20180716
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2019-09-04 11:49:57 [-0700], Stephen Boyd wrote:
> Can you try this?

yes, works.

Sebastian
