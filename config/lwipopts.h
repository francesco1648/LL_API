#ifndef __LWIPOPTS_H__
#define __LWIPOPTS_H__

#define NO_SYS                          1
#define LWIP_SOCKET                     0
#define LWIP_NETCONN                    0
#define LWIP_TIMEVAL_PRIVATE            0
#define MEM_LIBC_MALLOC                 0
#define MEMP_MEM_MALLOC                 1
#define LWIP_ARP                        1
#define LWIP_ETHERNET                   1
#define LWIP_IPV6                       0
#define LWIP_RAW                        1
#define LWIP_DNS                        1
#define PPP_SUPPORT                     0
#define LWIP_HAVE_SLIPIF                0
#define LWIP_SNTP                       1

#endif /* __LWIPOPTS_H__ */
