Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E791DDB46
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2020 01:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgEUXoz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 21 May 2020 19:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgEUXoy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 21 May 2020 19:44:54 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58BC3207D8;
        Thu, 21 May 2020 23:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590104694;
        bh=uDsCRqJpxOKU7WOkaHgp1RGWqZpp4vqZAQpY7BM9AzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuOEJ3/jwJaOErUDuEcY/Oc/rMjTYX8ZyyqYFl80doN9MAr7sgnR002g2KAVxWYJF
         ePoM1tTYEXpdup8ec0Dp0tjYhIYyWzZf9C1MCybHrENxweLYdiT2c4MqUd2vUOK/4m
         ryPRGaSPAj2mXD8WKRC7rWS51zS6xxc5q87tomPs=
Date:   Thu, 21 May 2020 19:44:53 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        stable@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [stable-4.19 1/3] padata: Replace delayed timer with immediate
 workqueue in padata_reorder
Message-ID: <20200521234453.GK33628@sasha-vm>
References: <20200521204051.1952184-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521204051.1952184-1-daniel.m.jordan@oracle.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 21, 2020 at 04:40:49PM -0400, Daniel Jordan wrote:
>From: Herbert Xu <herbert@gondor.apana.org.au>
>
>[ Upstream commit 6fc4dbcf0276279d488c5fbbfabe94734134f4fa ]

I've queued this and the 4.14, 4.9, and 4.4 series. Thanks you!

-- 
Thanks,
Sasha
