Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC352E3C9
	for <lists+linux-crypto@lfdr.de>; Fri, 20 May 2022 06:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245530AbiETEci (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 May 2022 00:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343734AbiETEch (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 May 2022 00:32:37 -0400
X-Greylist: delayed 870 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 21:32:27 PDT
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02hn2244.outbound.protection.partner.outlook.cn [139.219.17.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B241057B24;
        Thu, 19 May 2022 21:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj8ehRpxRqBT038PSUpI+Vybapyrey53WOyWUNWYU7ExiXhrjOGzquMIcQ7V6IAM2HtyDArIU9XzUmi/9TTKZ67F9MKKZ7A9s/qnM2sozj+SNSTghY9FNmjiwVYrIdm9JjWAJedOtJzTi3WiiCoPDyqSBp6++rHK/7Xatx9kqrcBPPdTicnhvVaHT+bHnJ0XQwKZY1S4ow6fkWByZ37QA4D2yKJVGAyjI7LOtSw9HGFDp80GUuQaybnu/WRd3KpnDk9N38lUAMalsH4ResIF/YlwBRm6yN84psRe8WXjWMwVir6/+S7KIZiAIsaeuzYV2EQDXl3fZDyAxQOMhhamvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=SWsx021REatQxgP+HQwzzJvbbFolmSCeNt6cVZYjTTM52GC/ATAd8hzYWMRxJdc3fZ7qiAM52eU48YVa1xZqcqkQBQMBCnpg//Sb91UZBANdev9N4lmDt32yFrRdmjQi0MobK/aC6AaHpBq5Mx1TSNFhivi0CK+V9Bcn1fy3I0DLBLMHl6y/u/qoxCmOi7rwQx2EKshZCA8aNbmXZiH48zYD8X3f3LWIlj+JN8c8zRxCxLTvSlFbxeKYM5AQro2v7Y+KF3umibfk6wWtAjtltDz9DcNHgD0WST9sm96nxdR7uuiwV0NEr84ZhKypmAHQpc33ZaipKvabLeHITjgImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=JxIiN/iLpPdOujent2b3XXyAx7tVhUh13Bifj9kSw83nTe9+1W1rsdiowzfeFTjLvdrDF/mWOEQrLhBQe8mqf79oCMshU85aSwknrdjTeDx8SkXNxHgsoIvCb1F4PmXrEmt3v+eePxogafZ4BpJOlBAkLEdrZAQ3FeYq3m73JjDpBvQA/0swObu75IKoz0UbQBy3BEyAIVmrnV/oP3QtIvkJZDZLR+Lhnz7KmnnkqzRru2sYuaqU8FtnnqaFTXVc+X11cJzH2HV/Tng5ztd3qEd7dPRvVwhBGWcgdzSjANR7WfvHa81FVfehrIrZjWnSCD91vAQ3wn57Lw73jfGnNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19) by
 SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn (10.43.110.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 04:17:53 +0000
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19])
 by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19]) with mapi
 id 15.20.5273.017; Fri, 20 May 2022 04:17:53 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ree
To:     Recipients <cuidong.liu@gientech.com>
From:   "J Wu" <cuidong.liu@gientech.com>
Date:   Wed, 18 May 2022 21:19:04 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: BJSPR01CA0015.CHNPR01.prod.partner.outlook.cn
 (10.43.34.155) To SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (10.43.110.19)
Message-ID: <SHXPR01MB06236B358B372A7E9A003A2689D19@SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e51a74f2-c62d-4e63-c767-08da391418e1
X-MS-TrafficTypeDiagnostic: SHXPR01MB0559:EE_
X-Microsoft-Antispam-PRVS: <SHXPR01MB055976F64BBA8CA7729D23A189D39@SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?fyv6K6Gz5XdMBW+OAdz3SR36z8mvo5AJQQSclzAmhg7wPp5Vdo5xiDcfZj?=
 =?iso-8859-1?Q?ycv7egMrA+K6Wwtt6xCpoJsamw42bLbGTSl2snldOJ/W/DcLLixaZxxNHG?=
 =?iso-8859-1?Q?GfPepT2uNbLHHe8Iii+db62TGVb5XEC+ycqLj3fDiAF+B6+57QfIYXlJ98?=
 =?iso-8859-1?Q?xc1Okg8oz3Y2lPoO/qPAjDnPllrzkAuyIxHRcoiNuMTXoaszWDt2tFWmxQ?=
 =?iso-8859-1?Q?Ji9jXiVfopm+wGkUd+31XsA9Asu9iWJgy7GOC6cmL+zNuZgcAE8r8TvMw0?=
 =?iso-8859-1?Q?PnFENis+UoBDkF0bhLAz8kmrRUuvP3h2HxzEk1NQFqbR0YqfFwBXN4lztQ?=
 =?iso-8859-1?Q?W0woDIhoOYAipYOeThYrmrlJTVgGsSRI/CMgbfhVgoZx+9q1xV9F/sI3Ur?=
 =?iso-8859-1?Q?aHsq1fReEfqPpMLtp08ssgWh+XLslXQhQTogyEhyZgqeDlbiXeTeqx3Amh?=
 =?iso-8859-1?Q?7PFHPW6zabr931033xt0pWQ02SMYpKhRIszvNl9obFBeHcfBZVayLlkLFU?=
 =?iso-8859-1?Q?3MVh42yMK4ddhsUUnc2Vj2ACCv+EX8vrew/Gg46OYdnewdHdWng2qS8BDz?=
 =?iso-8859-1?Q?xscetlgMKrWYVsGGgQNVsRksjNifbkeh2XbdS/37FuFuyVgw2OZgbnDrCg?=
 =?iso-8859-1?Q?/5RpeGqNw4e/5QNvnOUo/eFQRFMzvgLzZSobMEcS2XG6Z4V/kCxlNaCgUl?=
 =?iso-8859-1?Q?xAgCMS02Z/3GfY9ZCPjC2iLtfBhx3Vf9/l1d/U+vEl3Djf5JGGV7QO0Kdk?=
 =?iso-8859-1?Q?dgEPT+ulQIW/GZyOPmmW/R2d4AgKngUacKausgOdNOyeXN4p8Q5N8xUVnd?=
 =?iso-8859-1?Q?7DE5ojSZENmOt6w93olb9jfa6y6b5OZ8ls6U4Ioc1FNJvLdxWibdcuG+ii?=
 =?iso-8859-1?Q?k6+6HR86Fmb3o/bY5nW36HzB7A3rMwbkpRcthRqgxoBiNCWnH4/iyU2KuL?=
 =?iso-8859-1?Q?jZFAsnuAJNb8RVvNabbmSezmC7UjZOGKkwwtzX9wso/RognGiv8IQbMYLk?=
 =?iso-8859-1?Q?f23or/LKW6/AaUcf677M87cBT/5obwBiWcpOlV9pJONPlRuFE+/jSuseg/?=
 =?iso-8859-1?Q?hQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(6862004)(7116003)(2906002)(40160700002)(186003)(55016003)(8676002)(19618925003)(86362001)(6200100001)(6666004)(38100700002)(508600001)(4270600006)(8936002)(7416002)(7366002)(7406005)(3480700007)(38350700002)(26005)(52116002)(558084003)(40180700001)(33656002)(7696005)(9686003)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Bm2UYUk5lqriF4jfrqDyKDunw+2sI5ogSKbwqyO7pV2romZLk/9O1i2DnC?=
 =?iso-8859-1?Q?0iOsSi67CfsmDOFrhDkiQrDLugbLOkh+Z8awE/uPvhc6t1wUXu3hvHvPZ3?=
 =?iso-8859-1?Q?ShDpPrnqFF6icU6SEVGbAlKOkiIocjXyeyibRg+GbW/xwNuaZ3r2CDFfR4?=
 =?iso-8859-1?Q?O85cN8nmWcZ6J9RTok1PftDv5b3kePW3DPfNeujNKtM5DuMwwnkRqPjjYx?=
 =?iso-8859-1?Q?TiTcbiVAqtR+179RGxVZt2/Fos//hzJ6LRZ7nLNzOBzN7FjO1YpnCz7ckw?=
 =?iso-8859-1?Q?aeuJ9rm5laHrpufk19OALUjPRv/afbJ6hTRhRNKwH6HtPezB0rPPsQkcbI?=
 =?iso-8859-1?Q?DP7SP/Kd49cUmBCJXUIATlv+JHkoIub5zA+w4SPp0Ah0QMcSw8zJj7+7Cw?=
 =?iso-8859-1?Q?3hG0wkkp79cs+RjhdLq8WRmU6wNTONqKWecueo9x8lREAA15UsYlU2k8LF?=
 =?iso-8859-1?Q?LoB1w7fodayCSybE27y01TDX1vsQe43vF1TQtOquLStwOEEmkt5+Np32ui?=
 =?iso-8859-1?Q?Mv2ck1pmKUePxjps/IjaqWc6MAkp+Jhg90deGO/We7vNBeijbTHjzDhLPT?=
 =?iso-8859-1?Q?3oqpLnK8tN+N8vXaA55rJHWpRs5Sf0Kcz3P1JlZAujWHGkoNmM20rrkeaw?=
 =?iso-8859-1?Q?LwkahfcRm53OVbijU2rI1xphdOeDDii4MMpB1PU/gxkAosJNRp39Rfr5RY?=
 =?iso-8859-1?Q?vWvjPodagcKj+5MRZjDk7m4Vpe0yep1uMT0vrVmHPPdN/twMGfp3HP2rRw?=
 =?iso-8859-1?Q?GAG009C4VVVbShAe3u6qakplgKF/MjiM/BOT4a6qKGBW7laAsUlCF2K0OJ?=
 =?iso-8859-1?Q?dTBEoPqvWkjYKjHxhuEZfzG1RdIOSJN5yqcnMaoH7Hnxgc7E62GH8OWq98?=
 =?iso-8859-1?Q?Jks889/bTK/p47MGy2Jrt3ldMbFmh2CGv+S2rPTwTK7Xp/ATgtBeJNVDpT?=
 =?iso-8859-1?Q?dDO9sHGdNshWU7jxT8UmMA4y9fOWAFBRkRl4o3O0/jiuh/53pnPREEUQhv?=
 =?iso-8859-1?Q?Y8rhdP9TanFjFDKRg2pZTsrSGuRjmD7e0SYHwYHGvubMRtiGOzLtudLwFq?=
 =?iso-8859-1?Q?HGcT7EufZNFchCeD8SQYw3pxWOYTE6dRLizpuGMcn2yv+mTmAtuoB4JwER?=
 =?iso-8859-1?Q?bDgVaktJiZ4NHDsipO+TSVxbhFJHowOc1sgxkscR0TKrhoiDyPa2H7H5wq?=
 =?iso-8859-1?Q?icb94LsEn7p5ec3yQYuRAemy5owTo5xrVBOwJ290mgIh22NEGBTLvGL4qK?=
 =?iso-8859-1?Q?TygbCZXziVsV8RTlpx7vhiIHoFyiefp8XPwGQ3jlQCLTSME1vjhp6Y5TcI?=
 =?iso-8859-1?Q?L8SjUFofok+5wpV78ccji6GlxhOBVQdbZEp4ARRHLoRsnj8VFGbksVYz6R?=
 =?iso-8859-1?Q?xkCj8ADwBSR36d16jXABWNI8uc/rkaUv8NxQnxBEYTIbZWqG/pZhDkAZ4j?=
 =?iso-8859-1?Q?Qp1vcxVKnO47qgtFmA93dztCuwWl8LfkOaGbGPvEPxmRPr09lsmBGGjKo9?=
 =?iso-8859-1?Q?+4f9/UmglqwJqvwfK1Yzp6bcvCPSDgwM1c5Rm+5fgnX4Tniz/3URyTsGT1?=
 =?iso-8859-1?Q?j7gglZta+uHfpZKVrh1lQ+MB629RzjJhp6LmdREWHCwJAP3j6se4WChA6K?=
 =?iso-8859-1?Q?9VVOx0QmfdPsfwHnfNUGHoeOZ4luT9b/4Y+Efd+uWBVihUE3hEtHH7ABMj?=
 =?iso-8859-1?Q?PAcQrfbjPIlxfNXO/6mJBGHFhV/LfUOrAnSmUGbi+N8PrDeHRfq7MOa9GY?=
 =?iso-8859-1?Q?OGUg=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51a74f2-c62d-4e63-c767-08da391418e1
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:19:30.7175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILA7iEOWhFIownlPeixphZ589OdshJMlzKj+FXhQSdaEbiw4Or3NwV4fCb8ZhvW9j5lrMxtGMw0uQQlcYCIRiflKf6XquHrnoQvFfWT0ZLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Can you do a job with me?
