Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8997D1B8DB1
	for <lists+linux-crypto@lfdr.de>; Sun, 26 Apr 2020 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDZHzK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 26 Apr 2020 03:55:10 -0400
Received: from sonic308-17.consmr.mail.ir2.yahoo.com ([77.238.178.145]:38601
        "EHLO sonic308-17.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbgDZHzK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 26 Apr 2020 03:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587887706; bh=YdDyVS9QBRPCiN2YYZ/cryZSa6YEXSJJY6ujWZ06LZ8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Lu0C0GxfB/cEBZLDRcypTBUPPZBFsq3U7aBDTk+T6xOeIasBcDTexDHgtPK1m4KS41spmR4OkG2pOrg0nzCfmlPFIgabWOR3KR/nnLcyo6XcBnAKnhGxJQKt/Lxybr1cWwAEznrMB93NaEJQOd4PyGP2PCq2cDDpb9TF7NPDVcpd3WBZGSQbD1VVYvnmT67Rn/hyK1zopGJmsx6azTVhDgWfLRuC/maFMq9bNMGIQkNAJA0Yav2j/M9GZJg7fwcelx6NxUOoEbUf0d+0n4ZzlY8vYDdGy4LbP1V098HEIR6HHbmkOIBMoJsbwmS3ZU11V9nTT3bLVGHnCbYY8ZT3jQ==
X-YMail-OSG: JKJ5n2QVM1luaetNwdyE8jP9KuB03Fr3bUByrigGkwafMeUuaKwnkG_T2SyZOTb
 Qf00njcZfysjz.NtXrIrD9TCTE7b3lJe5MYQwvh8kjF.prYthigeIpnIkfniBnRBOb3Lzg.n81uE
 DLLzvfixchmeFaNc_q5fN2z6t6tdR66IKQCUlBn4cHXkDGQpazWVExEWVL7j4za2oLQaN7TrRWFy
 xrma1xjUjtF7CUb7Nr.AQRMgGMBzCaFMwpwXRXzQGntlG55EJAKt8IeV095N_DlZFGRNwK.sCQUz
 1L4EU3gK1M4jKm8Wy8.ZIJVeUXuWNF8ZyuLtOU7tE7GEK9.c40O2qKneW0zqPmvhaG6RxiqsvLM_
 LmuS0nnqcznjV1Vny2_5sfdOEILUFIRnuXPpr2Gs2jMKWzbjId7jTnRXjTrn_Ca8eAsTazssFvvV
 37s_ELAKaVxKuv1HoMKFVw8MS95SJS44R.Ql9FF1xx6BJqgx2uhwBnhD.B5ATr4oXxYkPGc2nQpN
 qPXP7DIqOo5EuBSShuene7rlTwrooGuLfU0uho095D8nxIoiz2mH9L97XziSV3hYv.VQkVOvS.jE
 GVLzhda96gRnBhyC9hNBPumFh7IHznZ5kgZ02NB5Sr25F1f4JpN3.whlTgx7omXbRkEe7hCpjsvl
 w0WSB8Z6sAeFgIOd5ZpXGn32EvsoV8_aawXjZ2tMJj3phZ0FArjwGAEabeXu.zEZSlV9Orox7G1q
 zwe_M8Q2yrNr09cMeaZV0Sj1chkSRe4yhI4FCQPoEwDlk2L9Bgx8.en_RGbl6gp4mg0nPCkRKRX6
 cDGQw9me0ovDiAgv9hz_GR5Lp.6bKXHReU_a4qGf12QLdLCzolNeH4_TFJvvzSYPAtYDb1rFX.80
 E3KL460_0aKSIfG49Qxm62noA8YasB733ntZTOQFPHTw7jmfZIgXz3nh9fK0UZ7ThxIBD.Lot_OS
 MuXB7GYhhQ6iNdj4QwPZhYfWh8vgWlyk0dx7B07dbc0P2uOdMyNprtt4EO0_GmitnDrrXhmohCtn
 PSRVOQUtPcmhC9yweXFZx8_20ci_2CcvdSQd4Bh1E7up2cN_Fn0Cztyesho2tdzczDmzxlhYpz42
 7uGTNOMR4U.SRN9g28fXekIDgKxqS6Lvdze474xK1q8MbTYE8s6amhrstjcPMIMI0BOTi4MGxTmY
 NJZGb7mpeR91Hbp7I4Oma86tzlPiK_YLtPwQzzbx5YrCBtM2JIjU81yZYIBxh1lgOFQBZPX6Zqm4
 IEgGxbaw..WsfQ_Z.72ZQnWYlqaQMAI6OXy_75R8pjXl46Yd7D.8ksnTe.93qahd.2DNbFRNmRf0
 If4qFCyd_JX_MSa4fN6u6NQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 26 Apr 2020 07:55:06 +0000
Date:   Sun, 26 Apr 2020 07:55:05 +0000 (UTC)
From:   Mr Moussa Dauda <mrmoussadauda@gmail.com>
Reply-To: mrmoussadaudaa@gmail.com
Message-ID: <1155083808.631600.1587887705864@mail.yahoo.com>
Subject: I await your urgent response immediately.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1155083808.631600.1587887705864.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



Dear Good Friend,

Good Day,

I am Mr. Moussa Dauda, Director In charge of Auditing and accounting department of Bank Of Africa, BOA, I hope that you will not betray or expose this trust and confident that i am about to repose on you for the mutual benefit of our both families.

I need your urgent assistance in transferring the sum of TEN MILLION FIVE HUNDRED THOUSAND UNITED STATES DOLLARS, U$10,500.000.00, immediately to your account anywhere you chose.

This is a very highly secret, i will like you to please keep this proposal as a top secret or delete it if you are not interested, upon receipt of your reply, i will send to you more details about this business deal.

I will also direct you on how this deal will be done without any problem; you must understand that this is 100% free from risk.

Therefore my questions are:

1. Can you handle this project?
2. Can I give you this trust?
If yes, get back to me immediately.

Try and get back to me with this my private email address ( mrmoussadaudaa@gmail.com )

I will be waiting to hear from you immediately.

Regards
Mr. Moussa Dauda.
