Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CDED465C
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Oct 2019 19:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfJKRPO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Oct 2019 13:15:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:49692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727984AbfJKRPO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Oct 2019 13:15:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2EC34B2E8;
        Fri, 11 Oct 2019 17:15:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35110DA808; Fri, 11 Oct 2019 19:15:25 +0200 (CEST)
Date:   Fri, 11 Oct 2019 19:15:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-crypto@vger.kernel.org, ard.biesheuvel@linaro.org,
        ebiggers@google.com
Subject: Re: [PATCH v4 0/5] BLAKE2b generic implementation
Message-ID: <20191011171525.GD2751@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-crypto@vger.kernel.org, ard.biesheuvel@linaro.org,
        ebiggers@google.com
References: <cover.1570812094.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570812094.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Oct 11, 2019 at 06:52:03PM +0200, David Sterba wrote:
> Testing performed:
> 
> - compiled with SLUB_DEBUG and KASAN, plus crypto selftests
>   CONFIG_CRYPTO_MANAGER2=y
>   CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n
>   CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> - module loaded, no errors reported from the tessuite

I forgot to add that this was on x86_64 only, I don't have big-endian
test setup. Ard, you offered to do the tests on my behalf, thanks.
