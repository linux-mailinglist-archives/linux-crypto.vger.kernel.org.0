Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7275313D6C7
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2020 10:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgAPJYn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jan 2020 04:24:43 -0500
Received: from sonic310-19.consmr.mail.sg3.yahoo.com ([106.10.244.139]:44224
        "EHLO sonic310-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgAPJYn (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jan 2020 04:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579166678; bh=Av1n2G9x6GY14ET1dXQDehbt9ATF52Kj3hnQ2cq2xGs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=nggjhXnEFQSHavY1bYyV8t9jCDrfwbZrcH+hFGw/MTvTpz80v41GmpFMFY3mQf+IuJzSfyWo3xFYgUWwwAgjr0O5YQuBP6t4dsPAZlwyEWeY/uatDVqVoppXLAiqNUJrGUmZ7THtMDPHAjuw/5wntP5CPQcKTuvAOjp0x2DOq+s2NR8WDz0C48ZowOo1bfMU1r/3tyhuCHm2zvIlycVj7a7lMD2lE1lvYnSbZ/H5oNExwdzid351a+Dt/CUWof64fxnhCOhj+QhuC4CM71VoiBpzYb2mHAYvlJG2KszAGRJsSGodor/h1PqYIB0ir17OMWx9SyH1pgrSbbFLSiRl6Q==
X-YMail-OSG: 8DvTwjAVM1lQ3HT.M8EJNaz0uafceFV58ATSUXwax2DbfEH43bHAYQ17mcnaXZO
 NG3XbmV4xfsLNIC5m471jMrmZTqhXHxFCqYFbtlWQGvW86BvgzJjBrIGV.xDfN8aLujukn5KyXrg
 uhcRH1FDdYWZNUGqZZKCUhrTClOStVBUodz9MfnL5EzIJtDxwbDTv6gWnH6rasQ2V2OQS5hBlcJV
 BTFJ89xgtBUhqbI.PRi4nF4rLHaxeXcpj8TZSbSjq95CUWw5O8ftnjvjnZOKox882djmTRnEJt.C
 d40sjfs_Pwr1PTI8PA6R3dzKeNLNHCt3CN24_BUuu195mKmW3SAfU_ZNTN52X9WwmVI.YAzrKkl4
 8nv178wnmUxXUBMVT5GdgE.UlxU7NssqbHtwpceVpY2F3hDZewdLoGnXRP_lreumSYgbIvnTQJ9R
 sbcEGjGh_ZB7o4HXWQbNuc1rgPUWEDAcoafXeZu0eJkQ7kC7IiPq9h5gfFSpMydIwglTCjwxNfDb
 ynTzbahNuWtHN6TbfDrTQZb1.VLiCsgqEAlYqj.KskDeVdd6_xdvF2DdxhewzC4QkI5v.rkTVBGA
 pLwJ.AwY2YHZRDMSh_ak_mBwaPdpemJlRy61z2Mft.cZNVQIaO58GB9bZCRiRyHXGoeiHEB.5z6p
 5vaXspmGqLNN_OYLKMaS_LYnQzSWJGCijDAoCxSy4JWwQXo6UTGcGNocw0JtrckvcEz6IjpcWe.N
 FbAgcCYlOt4Md5g1O_r.62frXCIFERcN_flpAp9ksWVE8E7._0zmuhFC083D_3.nFtXETAfREeRG
 lRkp0ZaDuA97F9DEEOgvOa1uoDOiVNBkaPmFcr0UxWsIyuoBiPvMh8rt9zN6H5FdLImm6XDYqPfU
 NgXpCJP9Fp.o4fOFNViDz1YNLJX9P1DazGIuzz3oXEIwQHsSYvciKfD4mqxqr4mJ33eCoxM7.BFQ
 hpq5v.Ma.Gz1HxmY4MoCqAh7AiQwLbJQn_tX8qtEU1QZ2NJhqnQfkHY99eFXx55TX683cYnGbW77
 qPe9ZbvP862rPU3RxdqQXnybl1tiVcHTaYVRnm.NpNc_E88Qhg0jAIPumzoqYFjuQPwIsBk4oPQp
 e1QnwlyOTD5emNRZRck5YSy8T7IlYS50bIWBztEMfDM32luV4FfQaZiH496Ywk0jH2qzfHCcac1H
 lh5aGvPye6XWYa2PnP7Wc1idldF18LtEIUh_VNnQxuCEZVUhNMc4OH6UG7e5u_jDYHISukRRh2u_
 VJQzNflLpJqV2KZB90AvqSX2IKTGzYvQpa11uciXLe25EH.8pjGbagDzKg8s7VnKGyamVBJJ7Dnu
 pHaRMKHJl
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Thu, 16 Jan 2020 09:24:38 +0000
Date:   Thu, 16 Jan 2020 09:24:33 +0000 (UTC)
From:   Mss Binta <mssbinta22@gmail.com>
Reply-To: mssbinta22@gmail.com
Message-ID: <1433111491.2016445.1579166673326@mail.yahoo.com>
Subject: Good,day
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1433111491.2016445.1579166673326.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi, Good day!
I'm Mss Binta, a single female from Coast d'ivoire,
Please mail me back i have something very important to share with you.
Thanks, as i wait to hear from you soon.
Ms Binta
