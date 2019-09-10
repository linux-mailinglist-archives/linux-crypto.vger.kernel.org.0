Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA735AEA50
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Sep 2019 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfIJMZk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 Sep 2019 08:25:40 -0400
Received: from sonic302-21.consmr.mail.ne1.yahoo.com ([66.163.186.147]:41441
        "EHLO sonic302-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391687AbfIJMZj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 Sep 2019 08:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1568118338; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=Iy2laReeF0kfoYA0ikj9W5h8nyVukqKRnzKnD/vwvr0GnQ2QvAUGPf1lucDZbwEdIsLrBBZl1rWNH716x/DvDG5EALDwSzQp6HJ5PeGiVkKrdIfeBlvYqw5xYw6Mh5SI7es3GgSemiD1MsPYCcCEq/NXIQgIKeQYMkYGage9iSwbGkulQO2CHlH94XnQ6O/Km/aPkUJkDuU0R5/rInCz6hxtx+SEhE1U52kHQeFqpsnGXNVSfq5KT5z+UH8rHRONf+HBgDs5UleS8tk8Y9i8ikmIXYuo3aHNpdOPJAU28P3/RhKBokK4OCJBQwx8UvTTPbqFhGv+/+ZWePuVdOAl5w==
X-YMail-OSG: 6o92XAsVM1njTQGHD5bdvY1HY.V0p32MH.Fisw1GDIRKdxNriF.RUxRIlrdXYwh
 _2Ze2_lH2vEO74nFoHXWDaVL8HOA4Kk9eWt4GzciEDpGITzsGATctx_HNJqPrJVcG7hXF_5bSg5Y
 iQfFXrGoHyeosuqVbtB7TzgEvKzpX9X1SXUp0GjCJESkpQ6zDrA93Yd9D2ZLR_rd7hedeG1p0cZZ
 4zGi_rzAy5uGLxRBsLWnsPMDoc79AT7uWK7x17WnSLsPIUpTUnFK2JKjW626GqrX8CtLo00RIarr
 _Z7Csv22Y3iyRajKDMZoKXyxkCGCx6ZY_w7WqRhUjLMEkedp_spOrUL4hQS8A.ERZhcCACPV9zWl
 C_YmLMPDORda2iSJr7_zgobFCKFDKDfIVFlbZofAmgrMVbOa9uk_9nsC.09kgyArYMApZrSXKaUA
 b1hpewgsTPIXMM8GYdp1OG3lL9L0xRk91zGR__mUMblzg7aR67qaEpPHdmgSjtfH4HmTwJ7Igolk
 PALmiZBAyY.IauSCglbxJojOvNkR2Ej.3mGyHppNv.toLpEvNG72opq.If7K67bvd1zVcnVis4HF
 C2izhKM5q2l2HFwOY_4.H6ri7lAOTvD2l1ogs63vC_RKTvKA9BE7gJ.Me3KsU80veBdghe9oCMsW
 Ppx8ITyZixYWAwge0s7xeua.5CeLadQmtyDwEsL_x3uR8MKd1GQg6eDGNKNoU0zfVu57ARceBU4H
 R0QqNeGqBhECpbL67hfxWHEGvxAtxKZ3o8JOTyp8uYxxQFLmBCSrx32ICn.ff2TsqDnMmFPh._IF
 dXZKRKV1cYJ9Eks7okzrHYQqvLoApfH8uTUrxMzna4G4TjLwwXgROKq9JYMe63kelDhfoOgIk..o
 rwLfOMzoO.pRR.qQH_SpBF1guoUtXh_9owW.Q9nZD1OjXLkBbsvOMCaHjoFibO0VswVW8hY1ZNIa
 cq5GNwKTlciMHhD32d8BXW87fKzJzX46Vn6CnENopCcoAbT4WUw34_PXpMA6SSTPp.LutBsI_Roa
 2ewAb.caN0evmzv1jEII0QGsrjWmSkQ5Hv_jvPTaBeqGwb2ngh6kW8u.3atSDwBSGcurFdGz85AH
 maYL2V3uyJXXijoTxpe9QS9MVnTZugqUTjR4POCNz2_BxnmtRZTQ46e5I3ZQApbNjHFbElzUWrbD
 hQiBERk3N7WPTEPX4h9rcHCDC_tB9AdPOWIrKcAHAGgPQvTIAjdx6L.oqLqEzkuuHIPqriA9s7dx
 .6_CVgTlU5rSdlGxsxaoeBb2diIu94PBxPqsh7Um6dDLQIzLBrR9D
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2019 12:25:38 +0000
Date:   Tue, 10 Sep 2019 12:25:34 +0000 (UTC)
From:   Aisha Gaddafi <agaddafibb@gmail.com>
Reply-To: gaisha983@gmail.com
Message-ID: <588297563.4913702.1568118334292@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaisha983@gmail.com)
