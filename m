Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF960970B
	for <lists+linux-crypto@lfdr.de>; Mon, 24 Oct 2022 00:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJWWbu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 23 Oct 2022 18:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJWWbt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 23 Oct 2022 18:31:49 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Oct 2022 15:31:48 PDT
Received: from mail.usefulaso.com (unknown [98.126.219.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9452319C35
        for <linux-crypto@vger.kernel.org>; Sun, 23 Oct 2022 15:31:48 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.usefulaso.com (Postfix) with ESMTP id ACE8880506D
        for <linux-crypto@vger.kernel.org>; Sun, 23 Oct 2022 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=usefulaso.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:to:from:from:reply-to; s=
        dkim; t=1666563995; x=1669155996; bh=6BCzqfPxvfWAXH1YzLdnC5ticl4
        240zfbKFE+TqgQzE=; b=YQ7YxK+WpDMJ6Gyke+/v41TbIBIKGvQjMsWjhQMVVGX
        J5hIQV/ES+fO7T8VOVli99RbQ3nlWlzAigg847AtocYeq7RVx6hPC/ghcoDVZaM9
        d6rQXajd+f1dXv59dPmvCn4b3iKBNkXXOEWHEni4ffadt2nckMONxzfEyclyviIk
        =
X-Virus-Scanned: amavisd-new at usefulaso.com
Received: from mail.usefulaso.com ([127.0.0.1])
        by localhost (mail.usefulaso.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J5VckS4qWfw2 for <linux-crypto@vger.kernel.org>;
        Mon, 24 Oct 2022 06:26:35 +0800 (CST)
Received: from usefulaso.com (unknown [84.17.52.166])
        by mail.usefulaso.com (Postfix) with ESMTPA id 9680480506C
        for <linux-crypto@vger.kernel.org>; Mon, 24 Oct 2022 06:26:33 +0800 (CST)
Reply-To: jacques_bouchex@yahoo.com
From:   Jacques BOUCHE <esther@usefulaso.com>
To:     linux-crypto@vger.kernel.org
Subject: =?UTF-8?B?Qm9uam91ciwgLyBEb2Jyw70gZGVuLA==?=
Date:   23 Oct 2022 23:26:04 +0100
Message-ID: <20221023232603.8445795397D82DAD@usefulaso.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,PDS_RDNS_DYNAMIC_FP,RCVD_IN_PSBL,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [98.126.219.146 listed in psbl.surriel.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 RDNS_DYNAMIC Delivered to internal network by host with
        *      dynamic-looking rDNS
        *  0.0 PDS_RDNS_DYNAMIC_FP RDNS_DYNAMIC with FP steps
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  0.8 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Bonjour,
D=C3=A9sol=C3=A9 pour cette fa=C3=A7on de vous contacter, je viens de voir =
votre=20
profil et j'ai pens=C3=A9 que vous =C3=A9tiez la personne dont j'avais=20
besoin. En bref, je m'appelle Jacques BOUCHEX, d'origine=20
fran=C3=A7aise. Je suis atteint d'une maladie grave qui me condamne =C3=A0=
=20
une mort certaine, un cancer du cerveau, et je dispose d'une=20
somme de vingt-cinq millions cinq cent mille euros (25.500.000=20
euros) que je souhaite remettre =C3=A0 un tiers fiable et honn=C3=AAte pour=
=20
son bon usage. J'ai une entreprise qui importe de l'huile rouge=20
en France et dans d'autres pays. J'ai perdu ma femme et deux=20
adorables enfants il y a 10 ans dans un malheureux accident de la=20
route. J'aimerais faire don de cette somme avant de mourir car=20
mes jours sont compt=C3=A9s. Veuillez m'envoyer un courriel =C3=A0=20
l'adresse suivante : jacques_bouchex@yahoo.com Que le Seigneur=20
vous b=C3=A9nisse.

-

Dobr=C3=BD den,
Omlouv=C3=A1m se za tento zp=C5=AFsob kontaktov=C3=A1n=C3=AD, jen jsem vid=
=C4=9Bl v=C3=A1=C5=A1=20
profil a myslel jsem, =C5=BEe jste osoba, kterou pot=C5=99ebuji. Jmenuji se=
=20
Jacques BOUCHEX, jsem francouzsk=C3=A9ho p=C5=AFvodu. Trp=C3=ADm v=C3=A1=C5=
=BEnou nemoc=C3=AD,=20
kter=C3=A1 m=C4=9B odsuzuje k jist=C3=A9 smrti, rakovinou mozku, a disponuj=
i=20
=C4=8D=C3=A1stkou 25 500 000 eur (dvacet p=C4=9Bt milion=C5=AF p=C4=9Bt set=
 tis=C3=ADc eur),=20
kterou chci p=C5=99edat spolehliv=C3=A9 a poctiv=C3=A9 t=C5=99et=C3=AD stra=
n=C4=9B k =C5=99=C3=A1dn=C3=A9mu=20
vyu=C5=BEit=C3=AD. M=C3=A1m spole=C4=8Dnost, kter=C3=A1 dov=C3=A1=C5=BE=C3=
=AD =C4=8Derven=C3=BD olej do Francie a=20
dal=C5=A1=C3=ADch zem=C3=AD. P=C5=99ed deseti lety jsem p=C5=99i ne=C5=A1=
=C5=A5astn=C3=A9 dopravn=C3=AD nehod=C4=9B=20
p=C5=99i=C5=A1el o man=C5=BEelku a dv=C4=9B kr=C3=A1sn=C3=A9 d=C4=9Bti. R=
=C3=A1d bych tuto =C4=8D=C3=A1stku daroval=20
p=C5=99ed svou smrt=C3=AD, proto=C5=BEe m=C3=A9 dny jsou se=C4=8Dteny. Pros=
=C3=ADm, po=C5=A1lete mi=20
e-mail na adresu jacques_bouchex@yahoo.com. A=C5=A5 v=C3=A1m P=C3=A1n =C5=
=BEehn=C3=A1.
