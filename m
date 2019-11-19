Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F529102F8E
	for <lists+linux-crypto@lfdr.de>; Tue, 19 Nov 2019 23:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKSWvJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 19 Nov 2019 17:51:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42306 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfKSWvJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 19 Nov 2019 17:51:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJMYCwP027134;
        Tue, 19 Nov 2019 22:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OU/iIcTfL+NN2Elm9hlv89PgC5gd5kNNmtwRG/9X9C8=;
 b=AEYiI9AUK0u9DGOUtTEI/4E9ZcGnkJU1yKNgi0IFIfNN6HRHSFhLu9JChZlhlMFVQVvO
 VNMpSSZ6X5Ip1Bo/2Ekcrqh1uqI6NP70tOoUBZcRZvgTkD+7TBgCQjsiSdG49h53j4SN
 1EK6E13+E1Kz2cb/udWk7Q22y85t6Joi8phm9dwrZZeGlsvEh+R3X9YnCPoPwZ1epXsC
 /42Kbc2UL79D8d+w293mGYcXcNk4q5eSuKDVTfusDjCR85S3awAgdxOXbiWhPUIJTrVC
 GS/wiOKgfmFziQWKF4XBMCm5K1qfNfhW5PiR9Y0bIWP5BSqcFXEShO1kMqMfAhEL6pdw og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wa92pt3kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 22:51:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJMcaYG192092;
        Tue, 19 Nov 2019 22:51:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wcembr325-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 22:51:00 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJMowlO002419;
        Tue, 19 Nov 2019 22:50:59 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 14:50:58 -0800
Date:   Tue, 19 Nov 2019 17:51:01 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] padata: Remove unused padata_remove_cpu
Message-ID: <20191119225101.t4ktiggrdyptd3ii@ca-dmjordan1.us.oracle.com>
References: <20191119223250.jaefneeatsa52nhh@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119223250.jaefneeatsa52nhh@gondor.apana.org.au>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190180
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 20, 2019 at 06:32:50AM +0800, Herbert Xu wrote:
> The function padata_remove_cpu was supposed to have been removed
> along with padata_add_cpu but somehow it remained behind.  Let's
> kill it now as it doesn't even have a prototype anymore.

Documentation/padata.txt still has a reference to this function that should be
removed.


I'm just now getting back to this series that I posted--admittedly a long time
ago!  :)

    https://lore.kernel.org/linux-crypto/20190828221425.22701-1-daniel.m.jordan@oracle.com/

Do you plan on posting other fixes in this area?  Asking so I know which to
work on further.  Thanks.
