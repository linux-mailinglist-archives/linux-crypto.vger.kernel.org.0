Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAB36BAC51
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Mar 2023 10:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjCOJkx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 15 Mar 2023 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjCOJkt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 15 Mar 2023 05:40:49 -0400
X-Greylist: delayed 1344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 02:40:48 PDT
Received: from mail.docworker.pl (mail.docworker.pl [94.177.230.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D1C2659C
        for <linux-crypto@vger.kernel.org>; Wed, 15 Mar 2023 02:40:48 -0700 (PDT)
Received: by mail.docworker.pl (Postfix, from userid 1002)
        id B40D1856E6; Wed, 15 Mar 2023 10:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=docworker.pl; s=mail;
        t=1678871836; bh=F9Uuk9o83BVy7SpscM/nJos6FHfnp2pKrNUqPErj3yg=;
        h=Date:From:To:Subject:From;
        b=kq7ciYw1S9DOkrIrW4JzRUbJ2DqCbtaoFF23tr/vgNxnOrVbpbq70oOZXmsX9KL0l
         4/3J49GZy17dSd/u2cEi/XxyTUbcUkKwV41fLmjT2JSTDaKe9Y9qHlwkwzn6+ykEFF
         3NRXG2rUw6e7dgQJMgc5ruE4jxTsScZUdOhwHSKKhR0LJLWJg1w/sqLtUXGvHUPP0z
         N639RX687M3OcMrlzwEA1PNWGFU/tDOpHUMDiEq7W6Ea53Y0XiSmed7PrOp8wNhZkY
         SFH5Hxg3zV/p4u0sMr3NDDCYYCGzsbU1hwl7CYAAJS0cMqQGcl0F4Q1xbDrgq9nQWc
         pn/LmxqCLP5mg==
Received: by mail.docworker.pl for <linux-crypto@vger.kernel.org>; Wed, 15 Mar 2023 09:16:08 GMT
Message-ID: <20230315084500-0.1.g.1mwr.0.1xqx0zosg0@docworker.pl>
Date:   Wed, 15 Mar 2023 09:16:08 GMT
From:   =?UTF-8?Q? "Mi=C5=82osz_G=C3=B3recki" ?= 
        <milosz.gorecki@docworker.pl>
To:     <linux-crypto@vger.kernel.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.docworker.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: docworker.pl]
        *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: docworker.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.177.230.24 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: docworker.pl]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2468]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Szanowni Pa=C5=84stwo,

Od blisko 8 lat skutecznie wspieramy naszych partner=C3=B3w w pozyskiwani=
u klient=C3=B3w. =C5=9Awiadczymy us=C5=82ug=C4=99 generowania lead=C3=B3w=
 z kilkoma unikalnymi cechami jak gwarancja realnego uruchomienia rozm=C3=
=B3w lub wymiana kontaktu. Nadmieni=C4=99 tak=C5=BCe, i=C5=BC kontakty pr=
zekazywane s=C4=85 na wy=C5=82=C4=85czno=C5=9B=C4=87.

Je=C5=9Bli w chwili obecnej poszukujecie Pa=C5=84stwo nowych zapyta=C5=84=
 i lead=C3=B3w sprzeda=C5=BCowych prosz=C4=99 o kontakt lub wskazanie ter=
minu rozmowy.


Pozdrawiam serdecznie
Mi=C5=82osz G=C3=B3recki
