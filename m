Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A7988587
	for <lists+linux-crypto@lfdr.de>; Sat, 10 Aug 2019 00:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfHIWE4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Aug 2019 18:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729867AbfHIWEz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Aug 2019 18:04:55 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 444552089E;
        Fri,  9 Aug 2019 22:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565388295;
        bh=7TZBzuwwyVy21cplHqvJ3PWLSZFkZxDpujWHD/DPAcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTGZEliSNBp8+EHNZRybE1tEF8W0W8of2LfSULZ+4uWR6SPTDvoVsl1pA1u82yStr
         Pa2/ucrilUrgfFKpmsGxOOVke3BBNDNQFF+Seovj3wwcMKZqwmIKF6st+m+6udGTen
         kEYNAgVSjDCSYWlsMcM0qkuP7OxzTS9jRuI9hTXw=
Date:   Fri, 9 Aug 2019 15:04:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [RFC PATCH v2] md/dm-crypt - reuse eboiv skcipher for IV
 generation
Message-ID: <20190809220452.GC100971@gmail.com>
Mail-Followup-To: Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
References: <20190808083059.GB5319@sol.localdomain>
 <MN2PR20MB297328E243D74E03C1EF54ACCAD70@MN2PR20MB2973.namprd20.prod.outlook.com>
 <67b4f0ee-b169-8af4-d7af-1c53a66ba587@gmail.com>
 <MN2PR20MB29739B9D16130F5C06831C92CAD70@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190808171508.GA201004@gmail.com>
 <MN2PR20MB2973387C1A083138866EE45FCAD60@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190809171720.GC658@sol.localdomain>
 <MN2PR20MB2973BE617D7BC075BB7BB1ACCAD60@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190809205614.GB100971@gmail.com>
 <MN2PR20MB29736FF8E67D83FEA5A52E14CAD60@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR20MB29736FF8E67D83FEA5A52E14CAD60@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 09, 2019 at 09:33:14PM +0000, Pascal Van Leeuwen wrote:
> Real life designs require all kinds of trade-offs and compromises.
> If you want to make something twice as expensive, you'd better have a 
> really solid reason for doing so. So yes, I do believe it is useful to
> be sceptical and question these things. But I always listen to good 
> arguments, so just convince me I got it wrong *for my particular use
> case* (I'm not generally interested in the generic case).

Or rather, if you want to take shortcuts and incorrectly implement a crypto
construction, you'd better have a really solid reason for doing so.

It's on you to show that your crypto is okay, not me.

- Eric
