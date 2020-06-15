Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815FB1F9F41
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2020 20:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgFOSUc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Jun 2020 14:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgFOSUc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Jun 2020 14:20:32 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549F4207DD;
        Mon, 15 Jun 2020 18:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592245231;
        bh=c0Nbm4zngEN1sy/wfi1WxfhlVFRANcYSd7wzR/K2LRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpceXcvsJ9sj5LJFKPg4v9M9aLRIUiWf1wEinECwiHE8Cqnpr9MJbUYsDbkZ1WhlR
         DAFGs/ZnT4WKhGqtLPj1PF/IyRpz7x5qtNRO+tbS1Gljt9Ovp5rl7kVQtclSO1CbK9
         FmQG0JL7VAdawx8/NBHIiqNGV5Wh+3//SKEZl/qM=
Date:   Mon, 15 Jun 2020 11:20:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        j-keerthy@ti.com
Subject: Re: [PATCHv4 0/7] crypto: sa2ul support for TI K3 SoCs
Message-ID: <20200615182029.GA85413@gmail.com>
References: <20200615071452.25141-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615071452.25141-1-t-kristo@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jun 15, 2020 at 10:14:45AM +0300, Tero Kristo wrote:
> Hi,
> 
> This is basically just a rebase of v2 to 5.8-rc1, and application of
> Rob's Ack on the dt-binding patch. No other changes.
> 
> Only driver side + DT binding should be applied via the crypto tree, DTS
> patches should be queued separately via ARM SoC tree (I can take care of
> that myself assuming the driver side gets applied.)
> 
> -Tero

Does this driver pass all the crypto self-tests, including with
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?

Please include details about testing in your commits.
