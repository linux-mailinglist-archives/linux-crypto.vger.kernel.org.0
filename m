Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1E215F0D
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Jul 2020 20:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgGFSyF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 6 Jul 2020 14:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbgGFSyF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 6 Jul 2020 14:54:05 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD81206B6;
        Mon,  6 Jul 2020 18:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594061645;
        bh=skQipfPTL6YPTiqHaJVpbTjmZQALpodNQWraJp2eJDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbpH+oQtQRAQcE0jN3zL1ao19Ns7yYZfk/e9XbzKaFw/7ZK0L+f0/YeeKuUuRiPAF
         4SOsjGeqsZRkminPzz1348zbW8lZr2RSYSQRnGMn4Czu3HzjHGWT7Vad0jLDqKt14J
         cuY69rdX2CbhOzk6TjM/iM0J5G2KFQ5fchp+NsVQ=
Date:   Mon, 6 Jul 2020 11:54:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-crypto@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 0/6] crypto: add CRYPTO_ALG_ALLOCATES_MEMORY
Message-ID: <20200706185403.GA736284@gmail.com>
References: <20200701045217.121126-1-ebiggers@kernel.org>
 <alpine.LRH.2.02.2007010358390.6597@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2007010358390.6597@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 01, 2020 at 03:59:10AM -0400, Mikulas Patocka wrote:
> Thanks for cleaning this up.
> 
> Mikulas

Do you have any real comments on this?

Are the usage restrictions okay for dm-crypt?

- Eric
