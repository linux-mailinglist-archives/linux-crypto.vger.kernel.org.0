Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598F32401D1
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Aug 2020 07:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgHJF6O (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 Aug 2020 01:58:14 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:18189 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgHJF6O (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Aug 2020 01:58:14 -0400
Date:   Mon, 10 Aug 2020 05:58:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1597039091;
        bh=EhlDaP1Qwtx3koaR0pyS5WffL/N49qcKSXYBwTnWYb4=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=MfYPYl04xGguA7vvg+NVO3X+8nXJxzM/2+VvlvMfNafV00hi2aFHJ06CvDtGRi4Z5
         HGpNOvUznXKF8+fUtpvjw8BA7kseDLVVKNwrFSy2JRWzfTY1PO1sdzm1LIbFB5w+Vo
         Utb1x/Y8/B5V2j7WG99lNOmiqSMPXV6mbIHfH9v4=
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Jari Ruusu <jariruusu@protonmail.com>
Subject: Announce loop-AES-v3.7r file/swap crypto package
Message-ID: <5WYd_g-fDp6UdcdFeahrpwdems49CGHdf2UxC66MnUNJEJEp3UCPtyN5vqgmwsr98gxUDbY5hMhOIw_vZywc5YNLmWUM4PW-slQ-37w8FNk=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

loop-AES changes since previous release:
- Worked around kernel interface changes on 5.8 kernels

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7r.tar.bz2
    md5sum e264e305c829d002a7a94376789f4adc

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7r.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

