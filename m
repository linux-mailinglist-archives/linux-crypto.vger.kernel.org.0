Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27133AD34
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Jun 2019 04:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfFJCuf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 9 Jun 2019 22:50:35 -0400
Received: from mtax.cdmx.gob.mx ([187.141.35.197]:11457 "EHLO mtax.cdmx.gob.mx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfFJCuf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 9 Jun 2019 22:50:35 -0400
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
        t=1560134808; h=DKIM-Filter:X-Virus-Scanned:
         Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Reply-To:
         Message-Id:X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-SAAS-TrackingID:X-NAI-Spam-Flag:X-NAI-Spam-Threshold:
         X-NAI-Spam-Score:X-NAI-Spam-Rules:X-NAI-Spam-Version;
        bh=U0Muiz5ECa3gaTzMJe13Eshf2iywdDpIp+lqwE
        FBq5U=; b=WeFCYIOSFWITSmQbK6V+hBO+szlnfQPpVJ1JncMB
        yjvexdKuBHmcwyh+FAI+vtryjlx96l4fKHwlrfjzbUZTQdQOvp
        6BZQuoIhFYoimFu41WGthkbfRegtxfUPoFpaT0GJ8R3vLFx+bB
        E8FlX0qG5qkxRhGZXfiB6jtmeesoV9g=
Received: from cdmx.gob.mx (unknown [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 69c5_6e51_fe8798e4_1b5a_4cc3_b535_aab3a4e0b886;
        Sun, 09 Jun 2019 21:46:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id A61B33C2238;
        Sun,  9 Jun 2019 18:00:18 -0500 (CDT)
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xY5GukZfz6ip; Sun,  9 Jun 2019 18:00:18 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id C9A8A2A224F;
        Sun,  9 Jun 2019 11:22:58 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx C9A8A2A224F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=72359050-3965-11E6-920A-0192F7A2F08E; t=1560097378;
        bh=U0Muiz5ECa3gaTzMJe13Eshf2iywdDpIp+lqwEFBq5U=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Reply-To:Message-Id;
        b=vvlBb7NQ+PovIKXrJYIkXPnDn8BPXf19T/QeGUNDDCrcmXOiKsNB8GwL3LhesKrLz
         AWIGK2hf6KguW66IHIjYBnDvIAKFtkGhJMdpSkicpzzukOMqwTaFJB+EpBNbT2l9CT
         CgOAv2q2X29dtx1N19Yp6Nnr2Rn8Qse4UuJGDJkI=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UndKAQuGTjvl; Sun,  9 Jun 2019 11:22:58 -0500 (CDT)
Received: from [51.38.116.193] (ip193.ip-51-38-116.eu [51.38.116.193])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 6AFDA1FCDDA;
        Sun,  9 Jun 2019 09:52:46 -0500 (CDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDIuMDAwLjAwMCwwMCBFdXJv?=
To:     Recipients <cilpinez@cdmx.gob.mx>
From:   cilpinez@cdmx.gob.mx
Date:   Sun, 09 Jun 2019 07:52:48 -0700
Reply-To: johnwalterlove2010@gmail.com
Message-Id: <20190609145247.6AFDA1FCDDA@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=d8iF8VrE c=1 sm=1 tr=0 p=d_9A9YPZgCEA:10 p=UhPmRW]
X-AnalysisOut: [QW4yN_uUvCwugA:9 p=Ner0o0mvyuUA:10 p=CwrrfTYHidcoWUP_FusY:]
X-AnalysisOut: [22 p=Z3hVr4-9LPz_iBwj1Snb:22 a=T6zFoIZ12MK39YzkfxrL7A==:11]
X-AnalysisOut: [7 a=o6exIZH9ckoXPxROjXgmHg==:17 a=IkcTkHD0fZMA:10 a=x7bEGL]
X-AnalysisOut: [p0ZPQA:10 a=dq6fvYVFJ5YA:10 a=pGLkceISAAAA:8 a=QEXdDO2ut3Y]
X-AnalysisOut: [A:10 a=uXetiwfYVjQA:10]
X-SAAS-TrackingID: 5b4cdfc5.0.366758587.00-2331.627010383.s12p02m003.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
        WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6564> : inlines <7098> : streams
 <1824042> : uri <2854447>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Ich bin Herr Richard Wahl der Mega-Gewinner von $ 533M In Mega Millions Jac=
kpot spende ich an 5 zuf=C3=A4llige Personen, wenn Sie diese E-Mail erhalte=
n, dann wurde Ihre E-Mail nach einem Spinball ausgew=C3=A4hlt. Ich habe den=
 gr=C3=B6=C3=9Ften Teil meines Verm=C3=B6gens auf eine Reihe von Wohlt=C3=
=A4tigkeitsorganisationen und Organisationen verteilt. Ich habe mich freiwi=
llig dazu entschieden, Ihnen den Betrag von =E2=82=AC 2.000.000,00 zu spend=
en eine der ausgew=C3=A4hlten 5, um meine Gewinne zu =C3=BCberpr=C3=BCfen. =
Das ist dein Spendencode: [DF00430342018] Antworten Sie mit dem Spendencode=
 auf diese E-Mail: richardpovertyorg@gmail.com
