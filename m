Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59666B41B6
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Sep 2019 22:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391358AbfIPUXa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 16 Sep 2019 16:23:30 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:44494 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732809AbfIPUXa (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 16 Sep 2019 16:23:30 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 16:23:29 EDT
Received: from darkstar.musicnaut.iki.fi (85-76-81-183-nat.elisa-mobile.fi [85.76.81.183])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id C0897B008C;
        Mon, 16 Sep 2019 23:17:50 +0300 (EEST)
Date:   Mon, 16 Sep 2019 23:17:50 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-crypto@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org
Subject: Re: [PATCHv2 0/7] Non-urgent fixes and improvments for omap3-rom-rng
Message-ID: <20190916201750.GF8201@darkstar.musicnaut.iki.fi>
References: <20190914210300.15836-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914210300.15836-1-tony@atomide.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

On Sat, Sep 14, 2019 at 02:02:53PM -0700, Tony Lindgren wrote:
> Here are fixes and improvments for omap3-rom-rng that's been broken for
> a while.

Thanks, for the whole series:

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
