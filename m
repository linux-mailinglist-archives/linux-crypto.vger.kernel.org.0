Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F1C551024
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Jun 2022 08:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbiFTGOe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Jun 2022 02:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbiFTGOb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Jun 2022 02:14:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE76264
        for <linux-crypto@vger.kernel.org>; Sun, 19 Jun 2022 23:14:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p5so3506299pjt.2
        for <linux-crypto@vger.kernel.org>; Sun, 19 Jun 2022 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rkrgLubJwdtOwiQSZV73I/R5b/hl34THH/3G/dpfdrs=;
        b=fAd3F+d939T3B6zUF8ALYs+gYnv8DGu5jHrZtEIuo6wYhQv4c0Fqqi2wT2VmDLb9oq
         EljyfquqX+O/N94k9DVeI/xL0bc/pNPNjKrg4Ff8eFs3ttWPMQkLyCFK70rmLGyaNQH/
         vPRpDnPz2Wd6OSBfVeO4tVqlOam7Jlv0bjzNN/2GgIXXDPKQ08LUNBsVkxFTjUoFclnp
         bfMBB8akY65j7COVWDr9jP87Q8ji1BXzRjzCBm6Svhi2fWZau2isuipWP5ZtJ8+bFmrX
         nCg3vbWAhZZhPP2+S+8vfZF9qOfE1RgTfMd5V1dyytGKrOdHSh+vo0IclDPzyxkZxW4u
         CZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=rkrgLubJwdtOwiQSZV73I/R5b/hl34THH/3G/dpfdrs=;
        b=sX7nvJtxOPb9gEez0U1OHskxYTkajqHhnkdamqfvx8btra4sDh1oPESsXudCNbZuBA
         w/i1Kn6ajJzrCDbopglXIPlZNE7pyDiGJZRK45jxuWdyt+gDau+ZYi2my4KdmxfuoNep
         Hr6JRPbsd3RJ5vGKg+6ZYbvCbbGRFHe6iiseX0c4OMXYgHb/4CEA12AQwcNxWV6wSp5w
         16SxUEo70WYUBpSNDAzS9HrtgpncoRQYRPgpKHLFxow5J3Oyc6vqu+cX8PLLh/+gJMhe
         lA5EJPlgq6KYKEq+LV61Buc2O4051aBYdF4TXKvSirp4/jshR0btNzJgV1EghTolGwqk
         roNQ==
X-Gm-Message-State: AJIora8OaeUSMh9r+gHd3rtsO88KxKT2GCWhDDMgLEiO9srolBFPH3Ro
        50j0H8W8xSfux/6pq+CW4H0ecnpVGgzuBGmtk2Y=
X-Google-Smtp-Source: AGRyM1ueuvnnTGhCmn7++yb0aipWsdnmWiGeB774qPLk6YYh/Bw2vt9lCf7tzmqXcxEb9lEu5+rTJ4UeqRoIyCdHW28=
X-Received: by 2002:a17:90a:a882:b0:1ec:918a:150d with SMTP id
 h2-20020a17090aa88200b001ec918a150dmr9879488pjq.137.1655705669942; Sun, 19
 Jun 2022 23:14:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:6922:b0:67:f674:f3a8 with HTTP; Sun, 19 Jun 2022
 23:14:29 -0700 (PDT)
Reply-To: ed2776012@gmail.com
From:   Elizabeth Domigo <garbahussaini9354@gmail.com>
Date:   Mon, 20 Jun 2022 09:14:29 +0300
Message-ID: <CAKEHr2EP1U4hyqMUBX6kQTM=DWPZ2WVPji-eNb4-W83fwEju0Q@mail.gmail.com>
Subject: Darlehen
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--=20
Hallo,

Suchen Sie ein Gesch=C3=A4ftsdarlehen, Privatdarlehen, Hausdarlehen,
Autodarlehen, Studentendarlehen, Schuldenkonsolidierungsdarlehen,
unbesicherte Darlehen, Risikokapital usw. ..

Oder Ihnen wurde ein Kredit von einer Bank oder eine finanzielle
Konfiguration aus einem oder mehreren Gr=C3=BCnden verweigert.

Wir sind ehrliche und private Kreditgeber, die Kredite an Unternehmen
und Privatpersonen zu einem niedrigen und erschwinglichen Zinssatz von
1,8 % vergeben. Interessiert?

Kontaktieren Sie uns, um das Darlehen innerhalb von 48 Stunden nach
der =C3=9Cberweisung zu bearbeiten.

Vielen Dank.
