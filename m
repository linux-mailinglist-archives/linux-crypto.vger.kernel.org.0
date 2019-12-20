Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A31127B87
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Dec 2019 14:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLTNKC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Dec 2019 08:10:02 -0500
Received: from sonic310-57.consmr.mail.ir2.yahoo.com ([77.238.177.30]:40059
        "EHLO sonic310-57.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727381AbfLTNKC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Dec 2019 08:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576847399; bh=rLzamwWDU6w+ljUNz15IdfH92SpsSZVAbr+GO8Whobg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mhDt51UYio0tpBLOzQGL+KXbHHiaH9KoMpU5+3HTsyR5wUIUl9p/BmGIdwNf9gHour9I96Ut/Ut8HWlZGE7AB8wlxxRTUTpIP9xc/rgZ39grUNUWFzx5nxwy8q/K9HbyczZvfAvmEYR4YSbBOwUadF+KLWIF6gC0a/WNHysD/diNOmtmZHHr66w5pd4RKOVY0YBfBpdKzm6iOcOJtF7iRFDKuVGX36cdAaB3vDBIIBlOz4qRI6OFo/R5dXMLDPZ002Fu2HO+RDHOT31b4zMXNAsCwZ8T2yKLfZIyIYspc5kvGIMhjtCoXwqQduiLSHF/AsPgJIU6ce9Au48izgS/vA==
X-YMail-OSG: 0eAZ52IVM1nyMsGhmt.mrRg6hkSz1QxoU0flBXAAGWQBaOPSAHb4Rwr7JKZgVUj
 t7xH_3x1VnVxwb8dgyIG0A1KjV42nTu0Umq.pNOKCHG9qTo0IXPBgusESBovd_oek6B.ai5Jw7C5
 qz4fugYo69qRR9k6c0R_DCM8XaEOjUGvx7eAYBjRw1QNE8QAt9hvcb6wyO6vPiM5PxO5xH8onnaw
 0b0o88jKKTpKsM9qvvuvbSoEvX1OrTtHsGRhoAKiOA0RRgXL9ZYc6uVEqEXydcWo1zsj2I7s4fp4
 hu5jlcUMWpL1uYeU1t3nATT44rIpAkzz_v73SNs4OkWAkKlCzqwMeISBbdzgfuRSn5fc46zzmhtB
 BJyxUN24dmQ73aY.KXVotR5vKkBUZ17XdoyQyjYg2m58Blj5Rg02yfAjTJucDg7TT.xInkA8WYww
 sjTZN3QcmPlxhB_C23_DNz_5_HgXz4hSUGh_whBpK0CHv49z4uLPCmVKjPgz202bzbUy_Q6pD4UI
 A_RdH0AoK7cX2BL4rhYs9fq3jq7kLRp6OqJ9jEsEPvu.cgUb6NwpB_OEkkvdGGjjbvL6LATBGu7J
 IMQpyhYT.gAI4eQ6KE5lYxpJfSxNlJHadwwSn.yNgKYqAVQiPcOz_Ep7NTtaNYm8oRURSC30zDwA
 mWylzhObgDDyfqMVrcsz46140kP0zp9ahEsMG_PBKcRYRtIYWvChxndRrIQIIex5_w9CVBxL4x2e
 Hl9wUAGKfQZI00UBhb5xhQ9VgFkeh5jYi2F5EUWGTHaxf1IVS12hvfv2SX2AMFMVGSzEP7pZrc9r
 EQzUoN5q.xcut.us1BbV1H1qVNUuXM0uT5UkYrvU6O5uD4nG1gmqGpO4.IbXE6Gf3AflsNpyAbAc
 Bg.7w6qWlnt.S8_SkI1PJsEfJiU99BAScb6DcfhMoVrPtR77lvWK_gdyE501MKpGdeNENLPUd323
 2PfhCHRIPBVIs5lS1wZ0GAOuII_O1dZfAJoKgL30SR7VDqbljqkZU9sUtqnBdxGj3EGYJgysM9a1
 keNo862TfsKgAGRxBL.WGlZbieIbKFGrF6jsPSLH7YNRu68dgbSkAgWrZ08BCxR4Ib.qqX640eEc
 Do2Go.diL1Zp0zZDepybNwDwv3dV78kHoFx6dGhMKCIgpv8vZ079Zntg.IqQXJaaRbiteBy5E5cl
 0AhZfsgp5Tvz.9pnMNzZOh.dpPLfxGVKPy964b42dA0f0v8SkJbMnH4LIdIswkVEZFkOVbIO0XJj
 2qnd6pB2Tc7AuoSIL3ZLys2sTHsyDw41jmVVyxv6_30_opo8_FlxZfSmmM4eHJKysscQSC.AqkqD
 yyhyezA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Fri, 20 Dec 2019 13:09:59 +0000
Date:   Fri, 20 Dec 2019 13:09:57 +0000 (UTC)
From:   "MR.Abderazack Zebdani" <zebdanimrabderazack@gmail.com>
Reply-To: zebdanimrabderazack@gmail.com
Message-ID: <2130130581.3113838.1576847397847@mail.yahoo.com>
Subject: MY CONDOLENT GREETINGS TO YOUR FAMILY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2130130581.3113838.1576847397847.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



Greetings My Dear Friend,

Before I introduce myself, I wish to inform you that this letter is not a h=
oax mail and I urge you to treat it serious.This letter must come to you as=
 a big surprise, but I believe it is only a day that people meet and become=
 great friends and business partners. Please I want you to read this letter=
 very carefully and I must apologize for barging this message into your mai=
l box without any formal introduction due to the urgency and confidentialit=
y of this business. I make this contact with you as I believe that you can =
be of great assistance to me. My name is Mr.Abderazack Zebdani, from Burkin=
a Faso, West Africa. I work in Bank Of Africa (BOA) as telex manager, pleas=
e see this as a confidential message and do not reveal it to another person=
 and let me know whether you can be of assistance regarding my proposal bel=
ow because it is top secret.

I am about to retire from active Banking service to start a new life but I =
am skeptical to reveal this particular secret to a stranger. You must assur=
e me that everything will be handled confidentially because we are not goin=
g to suffer again in life. It has been 10 years now that most of the greedy=
 African Politicians used our bank to launder money overseas through the he=
lp of their Political advisers. Most of the funds which they transferred ou=
t of the shores of Africa were gold and oil money that was supposed to have=
 been used to develop the continent. Their Political advisers always inflat=
ed the amounts before transferring to foreign accounts, so I also used the =
opportunity to divert part of the funds hence I am aware that there is no o=
fficial trace of how much was transferred as all the accounts used for such=
 transfers were being closed after transfer. I acted as the Bank Officer to=
 most of the politicians and when I discovered that they were using me to s=
ucceed in their greedy act; I also cleaned some of their banking records fr=
om the Bank files and no one cared to ask me because the money was too much=
 for them to control. They laundered over $5billion Dollars during the proc=
ess.

Before I send this message to you, I have already diverted ($10.5million Do=
llars) to an escrow account belonging to no one in the bank. The bank is an=
xious now to know who the beneficiary to the funds because they have made a=
 lot of profits with the funds. It is more than Eight years now and most of=
 the politicians are no longer using our bank to transfer funds overseas. T=
he ($10.5million Dollars) has been laying waste in our bank and I don=E2=80=
=99t want to retire from the bank without transferring the funds to a forei=
gn account to enable me share the proceeds with the receiver (a foreigner).=
 The money will be shared 60% for me and 40% for you. There is no one comin=
g to ask you about the funds because I secured everything. I only want you =
to assist me by providing a reliable bank account where the funds can be tr=
ansferred.

You are not to face any difficulties or legal implications as I am going to=
 handle the transfer personally. If you are capable of receiving the funds,=
 do let me know immediately to enable me give you a detailed information on=
 what to do. For me, I have not stolen the money from anyone because the ot=
her people that took the whole money did not face any problems. This is my =
chance to grab my own life opportunity but you must keep the details of the=
 funds secret to avoid any leakages as no one in the bank knows about my pl=
ans.Please get back to me if you are interested and capable to handle this =
project, I am looking forward to hear from you immediately for further info=
rmation.
Thanks with my best regards.
Mr.Abderazack Zebdani.
Telex Manager
Bank Of Africa (BOA)
Burkina Faso.
