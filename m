Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA3936BEB1
	for <lists+linux-crypto@lfdr.de>; Tue, 27 Apr 2021 07:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhD0FDj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 27 Apr 2021 01:03:39 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:32277 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhD0FDj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 27 Apr 2021 01:03:39 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Apr 2021 01:03:39 EDT
Received: from mail-03.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4FTqC26hjSz4wx2n
        for <linux-crypto@vger.kernel.org>; Tue, 27 Apr 2021 04:53:02 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="vmlx4ZUX"
Date:   Tue, 27 Apr 2021 04:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1619499178;
        bh=cJy50TP6/hb8uUVfCQ9I2hNu9ooMTjtr3JoQKuP++L4=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=vmlx4ZUXUb6aRrpus5lp/SBEu9bX/xmojVURHlkA6sfVCNKHgGuFeRkTWoHlIP2JU
         w61HxjeFNIc6OMrximffBBKl29WkPU34gEX6RCkFVa60x8+ow9oU7wX0H5HoabCoR9
         Csh4b2Y654kdm5aHCyEh3DHxyr5YwnZMm6HK05BQ=
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Jari Ruusu <jariruusu@protonmail.com>
Subject: Announce loop-AES-v3.7u file/swap crypto package
Message-ID: <fJU_yZGk-BwPNb2RKQz4FOEqD8rYlARIMCek3C1OTZjlUIqGVlWsJg7-r9rn-BQwmiyVbO3ZL_S_ujnmr05DDAnLe8XwvTDS0cEkas3Jdcg=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

loop-AES changes since previous release:
- Fixed CONFIG_HIGHMEM bug on 32-bit systems using 5.1 and newer kernels.
  64-bit systems, older kernels, or non-HIGHMEM systems were not affected.
- Worked around kernel interface changes on 5.12 kernels

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7u.tar.bz2
    md5sum 9b62adf1643a4e0ed45aafabe75bb524

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7u.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

