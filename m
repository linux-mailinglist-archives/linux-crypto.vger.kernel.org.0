Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58E22C3F45
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Nov 2020 12:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgKYLqw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Nov 2020 06:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgKYLqw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Nov 2020 06:46:52 -0500
X-Greylist: delayed 1387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Nov 2020 03:46:52 PST
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AA0C0613D4
        for <linux-crypto@vger.kernel.org>; Wed, 25 Nov 2020 03:46:52 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1khsti-000120-NE; Wed, 25 Nov 2020 12:23:42 +0100
Date:   Wed, 25 Nov 2020 12:23:42 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     linux-crypto@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: XFRM interface and NF_INET_LOCAL_OUT hook
Message-ID: <20201125112342.GA11766@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, netfilter-devel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Steffen,

I am working on a ticket complaining about netfilter policy match
missing packets in OUTPUT chain if XFRM interface is being used.

I don't fully overlook the relevant code path, but it seems like
skb_dest(skb)->xfrm is not yet assigned when the skb is routed towards
XFRM interface and already cleared again (by xfrm_output_one?) before it
makes its way towards the real output interface. NF_INET_POST_ROUTING
hook works though.

Is this a bug or an expected quirk when using XFRM interface?

Cheers, Phil
