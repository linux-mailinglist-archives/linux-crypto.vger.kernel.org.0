Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B7311E1B
	for <lists+linux-crypto@lfdr.de>; Sat,  6 Feb 2021 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhBFO4k (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 6 Feb 2021 09:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhBFO4f (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 6 Feb 2021 09:56:35 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D515C0617AB
        for <linux-crypto@vger.kernel.org>; Sat,  6 Feb 2021 06:55:36 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y18so12856835edw.13
        for <linux-crypto@vger.kernel.org>; Sat, 06 Feb 2021 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=ksDouNynZ4UUJrxzb0QSSs1QzwwWQC4l2yHEYsAWFV5TOD9qsnllWQ4nyY6rI98Ojv
         ESfEmCrEqaQl4DIEGs+wbdn8pXOCXOldgffbwqGbpHfEzRCqfGBT1L2aFXjdbeQkXKGI
         XA9ymxeEeKl4nqSs2FgCN/KfrBQqQeLAE+bcvEU8n/iaQd7nWFnWYvKNmgiEindl9Hla
         BBPmGq+CdcJIhE4vVq9mEsxmFLAt3Pvc/rE7gC7E5+WhYR4Im0lo7yX2050VebfvMa/0
         4CRsddJdi7lNj2XG3rQIA5oiZCK5QoMuCoCwGPZjh9iqohYe61/ZJgSUoVKnKtaMgSVR
         zFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=SW486S8GOruJoixty7OAbVugEOs9a7aezLqM9QrTDMrNqrvB7N91Sd1h73JqXWdKUy
         sU9WvwHMWnvTeRG5ivppvMf5MOhWGAXAwcYvK2CHPFWkKaWm4QfVlt6PrtflB/MbIcI6
         BOm/g2URRZV05NYl2BWAjvJOfHSM6b0vaauoAlF9Hvsoi0lN2Z+aBuE06Z2P99o1WEfj
         HlullJ+YUpmIoM3caG+4Np2RX1xJO91RG2xQ0sE9nYDldOpdI5A+jM46jTF4fVzVA04C
         PPqT0I+ZQTSmOQ90vwUaBXrO5UToWrGxttF5kL94wsY6zfO+86W5ngqTqwEv9VBdzqEX
         PjFQ==
X-Gm-Message-State: AOAM530j6IIx6ffItWoqS18XD6xZNCIHADQao6olBP3so7k1f6A+nUcr
        NEcn8DL4YmDcKMQGEd848dg8qk9fewNCXa1aU7o=
X-Google-Smtp-Source: ABdhPJxE53aejdnNFP/m5btsw0zxp7EV0L8G7p/cuOc7byueXIajEjLJvSf1BsrSzW1j7d0XITKhPvQBQn1pAQEhtjs=
X-Received: by 2002:a05:6402:19bd:: with SMTP id o29mr8640196edz.161.1612623334837;
 Sat, 06 Feb 2021 06:55:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:55:34
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:55:34 +0100
Message-ID: <CAGSHw-AUQPr4bh-y4zzCMqmdHQETdTrR5XQ8dgCXxizs0sBokg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
