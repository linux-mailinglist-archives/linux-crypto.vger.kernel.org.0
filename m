Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6103433BF
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Mar 2021 18:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhCURdF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Mar 2021 13:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhCURdD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Mar 2021 13:33:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BBC061574;
        Sun, 21 Mar 2021 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9NoXt0LgxhS8+ou896woBh2tyQeKy3Z6psM9Qtt/aGk=; b=UvvCYd2VbtZQo0C9YTIFkRI8WG
        DdheKA+NY79r+1lZXU+G3+aSkOskjR+ZYij9cViw2KqyGKBRhNocTqlmykTPpOWF8BrnL64Jfaw+D
        XLhlM+ksoyDk+DndmA+YRmp9mcHNQhnmoQypUdFnyZWUzowLrQzWqoSKTMOoJ4bKL5SU3HT/50GoQ
        rbc0iV5oRXOh+3oF8w3CW84XiOqjUmkObuxFbpMlmIz2BScsQFI0c7M/04/3I6DSvhfOc1V7YQFUy
        augLiP9Yis7LBhfJWSzsaQdZE/pDqCO2EtjKn8V6ISNaC86O6JX3c4+nfuQAfLKl9NccgGKVnPQsQ
        zdVII+TQ==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lO1wi-002QPn-DB; Sun, 21 Mar 2021 17:33:01 +0000
Date:   Sun, 21 Mar 2021 10:33:00 -0700 (PDT)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Aditya Srivastava <yashsri421@gmail.com>
cc:     herbert@gondor.apana.org.au, lukas.bulwahn@gmail.com,
        corbet@lwn.net, linux-kernel-mentees@lists.linuxfoundation.org,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ux500: fix incorrect kernel-doc comment syntax
In-Reply-To: <20210321120912.12905-1-yashsri421@gmail.com>
Message-ID: <196bad72-7551-f085-e9b7-351190ff9a44@infradead.org>
References: <20210321120912.12905-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_103300_466048_082F818F 
X-CRM114-Status: UNSURE (   1.76  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  LGTM. Thanks. Acked-by: Randy Dunlap <rdunlap@infradead.org>
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


