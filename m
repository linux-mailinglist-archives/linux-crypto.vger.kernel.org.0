Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32102727FF4
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Jun 2023 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjFHM1C (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 8 Jun 2023 08:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbjFHM05 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 8 Jun 2023 08:26:57 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1322D56
        for <linux-crypto@vger.kernel.org>; Thu,  8 Jun 2023 05:26:43 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-75d4094f9baso46907085a.1
        for <linux-crypto@vger.kernel.org>; Thu, 08 Jun 2023 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686227203; x=1688819203;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2URvdto5eovnOZ9veTkEuCq8gCsNpoi88vZrtanDiw=;
        b=P/sKsm00oCtSlg5BXT6cslQ9CkH2LUVwC33SEH5eaq+tPc09ea4oqveEm/sVlHSgvb
         AtQsTygYyVDO5d5b2Se9XP6rDfsYZwan+gh7Qyesd+W7wAxKNBftOxVdemDJmNjwidK/
         Cn/wlJOYxJabkznkDAZ+Xavsm5UcsiEQvpKLFtRBut2TMiEEm0aiacv06rmo3yBEKpn2
         4dBxfdm10qUhztEEhpzIdb4hdzjVlv8brHeG3HYLcwgnzaNMLNDzQt9vbnjmBQfd0XTM
         zBp6+zE6GyR7wrdvdnA26ISqKvyEc/fZc7OtSBu6C3MrzESSirku9lbJiJkIyHjxruIQ
         Mhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686227203; x=1688819203;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2URvdto5eovnOZ9veTkEuCq8gCsNpoi88vZrtanDiw=;
        b=PS7dNXMLXjEENzcDHcAIBoUWumtNPEuau+VHW3E3ZLR6udznUiEOtjJzA7g4kUwPL3
         NzMVdm5OakVbwvdMG9MZvjlyyuCjFmZJLsxN0Szowxwhf20L+klfpk6dtkMOUhgVEQR7
         eyMAXXuvTa2JWHjkFPvsQuAduqEKOGxo4P/rjS6jzi5Kc7uBrX4CMj9cZCmtgtcalx/6
         p0XsnpnWW5z1Zr8lrsh9ZhrB/lzy2112EaR7r0skdEvVBWJR3xzbHIwDhUZIiuil7DNU
         Gl3K6IQFwgfefXlMNRMk3r217zmukXIkotl4QeB+5bvLIZD015B3bTsLK0xOa1RwPJkk
         gdXA==
X-Gm-Message-State: AC+VfDwYik27yyE/lsRpIy07foGiDTYPp1iZ8PBcAHkOrZAU8qMI8t4X
        e0n4fbBk6+A4taB1kNOdkGRTQa2RkpFxL1VLXY+vIsDjr5eIow==
X-Google-Smtp-Source: ACHHUZ56CXoUQUcvzxm94pRLtum4/Tr+9T8qQhRCOVBk7qCpI3tDEmZf8YfJhgvLj3Yl6bmBElZ55sgX6f729xWZwXA=
X-Received: by 2002:ad4:5de7:0:b0:62b:4e7e:8aba with SMTP id
 jn7-20020ad45de7000000b0062b4e7e8abamr1232957qvb.60.1686226812125; Thu, 08
 Jun 2023 05:20:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:f5ce:0:b0:61a:6ff1:329c with HTTP; Thu, 8 Jun 2023
 05:20:11 -0700 (PDT)
Reply-To: markusblocher3@gmail.com
From:   Markus Christoph Bloche <ahmadtijjani3737@gmail.com>
Date:   Thu, 8 Jun 2023 13:20:11 +0100
Message-ID: <CAEHyr=3GFftQi8sd7C38Thnrk-hs_qqH0j1t=3zeW3w+NuoiPA@mail.gmail.com>
Subject: SPENDENANGEBOT VON 1,000,000.00 AN SIE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

HALLO HALLO,,

   ich bin Markus Christoph Bloche,
Vorstandsvorsitzender/CEO/Gesch=C3=A4ftsf=C3=BChrer,
Dottikon ES Holding AG. Ein Schweizer Gesch=C3=A4ftsmann, Investor und
Pr=C3=A4sident/CEO/Gesch=C3=A4ftsf=C3=BChrer, Dottikon ES Holding AG. Ich b=
in dabei
Das Ruder von 9 Unternehmen, deren Vorsitzender ich bin
Evide AG, Chairman, Chief Executive Officer und MD bei Dottikon Es
Holding AG, Pr=C3=A4sident und Chief Executive Officer von Dottikon Exclusi=
ve
Synthesis AG, Hairman f=C3=BCr Frugan Holding AG,
Vorstandsvorsitzender der agrocult AG und Vorstandsvorsitzender der
Cultivport AG (beide sind
Tochtergesellschaften der Frugan Holding AG) und Pr=C3=A4sident der Evolma
Holding AG.
Ich habe promoviert und mache derzeit einen Bachelor-Abschluss
von der Eidgen=C3=B6ssischen Technischen Hochschule. Ich habe beschlossen, =
aufzugeben
Jedes Jahr spende ich 25 Prozent meines Privatverm=C3=B6gens f=C3=BCr wohlt=
=C3=A4tige
Zwecke und an die Armen
seit dem Ausbruch der globalen Pandemie, die viele zu Verlusten gef=C3=BChr=
t hat
ihren Job und viele L=C3=A4nder versuchen immer noch, sich zu erholen. Ich
und meine Familie
Ich habe zugestimmt, 25 % meines Privatverm=C3=B6gens an Einzelpersonen aus=
zugeben
Jahr 2023 aus dem Gewinn meines Unternehmens, um zur Reduzierung des
Hochs beizutragen
Armutsquote, die durch diese globale Pandemie und die anhaltende verursacht=
 wird
Krieg zwischen Russland und der Ukraine, der viele L=C3=A4nder betroffen
hat. Also habe ich
beschlossen, 1.000.000,00 Euro an Sie zu spenden. Kontaktieren Sie
mich noch heute auf meinem
Pers=C3=B6nliche E-Mail: markusblocher3@gmail.com. mit Ihrem
Spendencode: EGIP/EWU2023/28392.
Sie k=C3=B6nnen auch =C3=BCber den folgenden Link mehr =C3=BCber mich lesen=
:
https://en.wikipedia.org/wiki/Markus_Blocher.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dies ist noch einmal Ihr Spendencode: EGIP/EWU2023/28392.
Bitte antworten Sie mit dem SPENDENCODE auf meine pers=C3=B6nliche E-Mail:
markusblocher3@gmail.com.
  Wir hoffen, Sie und Ihre Familie mit dieser Spende gl=C3=BCcklich zu mach=
en.
Um zu best=C3=A4tigen und sicherzustellen, dass dies 100 % legitim und echt
ist. Besuchen Sie mich bitte
Verifizierte Google-Seite zur Best=C3=A4tigung und um mehr =C3=BCber mich z=
u erfahren:
https://www.bloomberg.com/profile/person/6131291?leadSource=3Duverify%20wal=
l,
Mit freundlichen Gr=C3=BC=C3=9Fen.
Markus Christoph Blocher, Pr=C3=A4sident/CEO/Gesch=C3=A4ftsf=C3=BChrer, Dot=
tikon ES
Holding AG.
