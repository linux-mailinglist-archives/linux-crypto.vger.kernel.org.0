Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8142B1B2912
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2020 16:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDUOJt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 21 Apr 2020 10:09:49 -0400
Received: from ozlabs.org ([203.11.71.1]:43201 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgDUOJt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 21 Apr 2020 10:09:49 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49656d3Gtdz9sSt; Wed, 22 Apr 2020 00:09:44 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a8c0c69b5e95e8f155480d5203a7bafb8024fd93
In-Reply-To: <1587114029.2275.1103.camel@hbabu-laptop>
To:     Haren Myneni <haren@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     mikey@neuling.org, herbert@gondor.apana.org.au, npiggin@gmail.com,
        linux-crypto@vger.kernel.org, sukadev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Subject: Re: [PATCH v6 1/9] powerpc/vas: Initialize window attributes for GZIP coprocessor type
Message-Id: <49656d3Gtdz9sSt@ozlabs.org>
Date:   Wed, 22 Apr 2020 00:09:44 +1000 (AEST)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, 2020-04-17 at 09:00:29 UTC, Haren Myneni wrote:
> 
> Initialize send and receive window attributes for GZIP high and
> normal priority types.
> 
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a8c0c69b5e95e8f155480d5203a7bafb8024fd93

cheers
