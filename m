Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8207158855
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Feb 2020 03:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgBKCis (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 Feb 2020 21:38:48 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53460 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgBKCis (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Feb 2020 21:38:48 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j1LRm-0000Gc-SJ; Tue, 11 Feb 2020 10:38:46 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j1LRi-0006BZ-E5; Tue, 11 Feb 2020 10:38:42 +0800
Date:   Tue, 11 Feb 2020 10:38:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     linux-crypto@vger.kernel.org, heiko.carstens@de.ibm.com,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 3/3] crypto/testmgr: add selftests for paes-s390
Message-ID: <20200211023842.5n7qb2jbrpneyabf@gondor.apana.org.au>
References: <20191113105523.8007-1-freude@linux.ibm.com>
 <20191113105523.8007-4-freude@linux.ibm.com>
 <20191122081611.vznhvhouim6hnehc@gondor.apana.org.au>
 <403c438d-1f3e-f25d-8df2-4f03d9ef731c@linux.ibm.com>
 <e97a3c21-3364-728f-3706-0ed208a22b06@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e97a3c21-3364-728f-3706-0ed208a22b06@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Feb 10, 2020 at 08:19:25AM +0100, Harald Freudenberger wrote:
> Hello Herbert
> 
> sorry for my pressing ... but I received questions from a distro about if they can pick
> this. And the pre requirement is to have this upstream accepted. So will you accept this
> and it will appear in the 5.6 kernel or do you want me to do some rework ?

Hi Harald:

It's too late for 5.6 I'm afraid.  However, if you can get them
submitted right away then 5.7 is certainly not a problem.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
