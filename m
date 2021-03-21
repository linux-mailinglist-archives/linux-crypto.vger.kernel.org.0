Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D76D3433BD
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Mar 2021 18:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCURcc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Mar 2021 13:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCURcC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Mar 2021 13:32:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C61C061574;
        Sun, 21 Mar 2021 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rj8WpwRk4oq0rfTiGxdtQAbZTUsGNGnH6FA1//XmoNA=; b=ZCuoOaCcBbKZ4sfRkHPnVzfd0b
        9a51K7c9A2cVylQPKpCLx/ZL3yN8q/BjPRkftoCpE9iTinUjAvppeLqeD1XJA3PD9EvfRlwpYIQXi
        oUXOonQkG5CMMeqpFhXd/m8HHtkV8k+7I+5avLMQfgihg+uYLNzngCPeloTMaO8HPYHo4gfjPrjlB
        4WUhC9fKnVr/dtKY2KKkVF/iFEvANMG8ADvIsU0esexYUdOwkQtBwn5AAzd1iK/CkxJE/HbVt8/C6
        HM44657IfyVcVaq4fH+olN9jO70VhAMiB4lhxnyQli9JExHxvN9440Trm864N61d97b2exVLqEcZy
        doH1BKHA==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lO1vf-002QNq-GW; Sun, 21 Mar 2021 17:31:56 +0000
Date:   Sun, 21 Mar 2021 10:31:55 -0700 (PDT)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Aditya Srivastava <yashsri421@gmail.com>
cc:     herbert@gondor.apana.org.au, lukas.bulwahn@gmail.com,
        corbet@lwn.net, linux-kernel-mentees@lists.linuxfoundation.org,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: amcc: fix incorrect kernel-doc comment syntax
 in files
In-Reply-To: <20210321120832.12837-1-yashsri421@gmail.com>
Message-ID: <7ef98c7-b028-d9ca-88b3-dc4f282effcf@infradead.org>
References: <20210321120832.12837-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_103155_570995_721D9626 
X-CRM114-Status: UNSURE (   1.76  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Looks good. Thanks. Acked-by: Randy Dunlap <rdunlap@infradead.org>
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


Looks good. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


