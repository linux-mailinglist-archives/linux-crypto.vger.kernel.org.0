Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F237D1A2683
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Apr 2020 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgDHP4J (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 8 Apr 2020 11:56:09 -0400
Received: from sonic315-13.consmr.mail.bf2.yahoo.com ([74.6.134.123]:43057
        "EHLO sonic315-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729804AbgDHP4J (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 8 Apr 2020 11:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586361367; bh=4lq1pI7+GIBy0FlIfk7AdjyT+HFsTWpCQ4liJABsm/c=; h=Date:From:Reply-To:Subject:References:From:Subject; b=btIsBdYGeiQOhdtTO3CpV20kvmRsR6ptP6lXRhQvdE/R/J9mCOEEe6cIzp1rRKinHYYiqYkkQYN5SdOUU0XXwdahKSHuGKVyTRO1ANHTjKACsvKPBXnbd9s+9hDfIzCOd8m5LBDOZgpJSuOBQ6tQvv2cH30chyioQXqufiW6VlOT1unjEde70n60c5kO/DiIoExNynyKNDu1GBkeRs0oEAjfe7R7+UH9uMDn47pvfIWHHm2l7udEq18pWy4jIJa1ypWjSqfim1n2t8k/lZ7v0Ko2GHDT1Swqj5mfcOjAqKN/nnbSe/9H7TTEfr5FZxl9UF8DkPxiPO6ieMNKOAa9ow==
X-YMail-OSG: ySFYItwVM1mGHMbhQAgkQnmOGKaPFOmByIyVSOuD1IQyP4ymshoXoh.x3D7fQ_k
 lrS8rALE4d_PO30thkz8vE..9zAFenana5LAFeFdw0m7K5CZsRUX7_Afu7hfPzYjq3LY0Y6vvOAX
 52WVnmKULJgVjTwl.1grTK9qPJ.ECgMAqfpCerd4maLFroo4pFn1cy6qfLIgtc2yR9jbbSqUnLEb
 9PK3W7c72pQZ8tHBEZI03mUR1yALWUwjI7cHwW5S6FLw4OQgiHhLLw7Z_on0.qAOyKl34IYmPFyo
 PvncHDIHUYEhidtEtcPrQv1jmBijjimvwrJea857TLyiAKyviktKCJpFa3XlVtCFU0DYkQGIGCbx
 0I73i0n5RzeAvfUzrYpcbgwCavIttemMLvKHHF414fQu2Volmigmk8ETLvrdJOeMsWWvMqHRcZsd
 9Mcv57UTXpGNApWBz6xdtBLm0BiULhzkjmbt3aA.KhRJBMYKNnXxOjkGykYo.wRdFLO7tNxN95eh
 3N9unmbRrsoIBeXiY3FitNghDhygrqn.R1x0eDv9tKBAP.vGW4ITtcDGXemPOgzgumbtd1fms2mr
 OptRCeAnKz9FOpQX75.KW1rH85BicZ1u2re3_3YEWpCuED3QlX3upu3rIdw.PbFmzWG.SdzaCz2v
 cad.gmoW3WY3bWVicCFHz2mg2odZyK18O3d.zEbPusN2VCCpKvDWveoiHyped4oo90YYhjfl0XgY
 cA_XOhqdYIpr5ZZildV4iFmhnr8QRCIYY69iRqwYDQO.zGevNJc6BbvBgUF_XKMS7PTgGwhXhgEV
 inSGclcf6F7PNxIyZXVpSGp.29HlOqvDwjgrSNE__POdGFSPj7YpXzvTpMGd6i15szDbmWgYJfbU
 Qg6dtP.ryr5Br0jKnZdepfg.mlxN3W0mHnNZmj.8LVZR187rZVldYXZTPWwxFBxJMNBcKsG1q7Ld
 e8RRQDg3mpaxLCSa2I3W4Pnzwi5mvr68oXhtPr_IdlqCUtMOIvWjffDJB.xuo64ZWkME1muxKi3V
 AdTmOR9NXgipwbUoYgRMbRiF7FVs9FddRLl7Qp6NVvHoFjNoD3HllZMkhQ4aNlmbAskyW8ZimOJC
 B3p_TJB.8uOJ4lTKV4FLO.GL2_qM7lrVrn2uezH8PxOu4XUjpN1ovcAccYMt64YAkG03hTwyyPKO
 GSlYpfsoc.rh7J6LYTxfbI1me7EDpFCiMv3_G4kIsjPbMkyqse8fIMseX3lDI9S_cSw5WLP_T0PO
 gBASbUI2Qt1t4sPpMTwqOMxAEb8X2xd.TvbM2d2obB9a7qxB84qbsUvmYIByFY0xlj2FYxkLBV54
 QdGuS
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Wed, 8 Apr 2020 15:56:07 +0000
Date:   Wed, 8 Apr 2020 15:56:06 +0000 (UTC)
From:   Theresa Han <serena@lantermo.it>
Reply-To: han.theresa2017@gmail.com
Message-ID: <921108282.1676228.1586361366977@mail.yahoo.com>
Subject: =?UTF-8?Q?Pozdrawiam_was_w_imi=C4=99_Pana?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <921108282.1676228.1586361366977.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15620 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Drogi Beloverd

Pozdrawiam was w imi=C4=99 Pana

Nie mog=C4=99 sobie wyobrazi=C4=87, jak si=C4=99 poczujesz, otrzymuj=C4=85c=
 nag=C5=82y list z odleg=C5=82ego kraju na dalekim Wybrze=C5=BCu Ko=C5=9Bci=
 S=C5=82oniowej i prawdopodobnie od osoby, z kt=C3=B3r=C4=85 nie jeste=C5=
=9B zbyt blisko spokrewniony. Apeluj=C4=99 do was o odrobin=C4=99 cierpliwo=
=C5=9Bci i przeczytanie mojego listu dotycz=C4=85cego was w tej wa=C5=BCnej=
 transakcji

Jestem pani Theresa Han, 65 lat z Wybrze=C5=BCa Ko=C5=9Bci S=C5=82oniowej, =
cierpi=C4=99 na choroby nowotworowe. O=C5=BCeni=C5=82em si=C4=99 z panem Jo=
hnson Han, kt=C3=B3ry by=C5=82 wykonawc=C4=85 w rz=C4=85dzie Wybrze=C5=BCa =
Ko=C5=9Bci S=C5=82oniowej, zanim zmar=C5=82 w szpitalu po kilku dniach.

M=C3=B3j zmar=C5=82y m=C4=85=C5=BC zdeponowa=C5=82 w banku na Wybrze=C5=BCu=
 Ko=C5=9Bci S=C5=82oniowej kwot=C4=99 2,5 miliona USD (dwa miliony i pi=C4=
=99=C4=87set tysi=C4=99cy dolar=C3=B3w). Cierpia=C5=82em na raka, niedawno =
m=C3=B3j lekarz powiedzia=C5=82 mi, =C5=BCe mam ograniczone dni =C5=BCycia =
z powodu problem=C3=B3w z rakiem, na kt=C3=B3re cierpi=C4=99. Chc=C4=99 wie=
dzie=C4=87, czy mog=C4=99 ufa=C4=87, =C5=BCe wykorzystasz te fundusze na ce=
le charytatywne / sieroty, a 20 procent b=C4=99dzie dla ciebie jako rekompe=
nsata.

Podj=C4=85=C5=82em t=C4=99 decyzj=C4=99, poniewa=C5=BC nie mam dzieci, kt=
=C3=B3re odziedzicz=C4=85 te pieni=C4=85dze, a krewni mojego m=C4=99=C5=BCa=
 s=C4=85 bardzo zamo=C5=BCnymi lud=C5=BAmi i nie chc=C4=99, aby m=C3=B3j m=
=C4=85=C5=BC ci=C4=99=C5=BCko zarabia=C5=82 na niew=C5=82a=C5=9Bciwe wykorz=
ystanie pieni=C4=99dzy.

Prosz=C4=99 o kontakt, abym m=C3=B3g=C5=82 poda=C4=87 wi=C4=99cej szczeg=C3=
=B3=C5=82=C3=B3w, a wszelkie op=C3=B3=C5=BAnienia w odpowiedzi dadz=C4=85 m=
i miejsce na pozyskanie innej dobrej osoby do tego samego celu.

Oczekiwanie na twoj=C4=85 piln=C4=85 odpowied=C5=BA U Boga wszystko jest mo=
=C5=BCliwe.

Wasza siostra w Chrystusie

Pani Theresa Han
