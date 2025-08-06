---
title: Three Ways to Identify Program Dependencies in MATLAB --- `inmem` function, `matlab.codetools.requiredFilesAndProducts` function, and MATLAB APP Dependency Analyzer
categories:
 - MATLAB
tags:
 - MATLAB Software Development Tools
date: 2025-07-21 11:50:44 +0800
last_modified_at: 2025-08-06 13:46:57 +0800
---

# Introduction

In MATLAB, there are three ways to identify program dependencies[^1]:

- `inmem` function
- `matlab.codetools.requiredFilesAndProducts` function, and
- MATLAB APP Dependency Analyzer.

In this post, I would learn and record how to use them.

<br>

# Method 1: `inmem` function

MATLAB `inmem` function is to return “names of functions, MEX files, and classes in memory”[^2], so it can help us figure out what functions etc. are called when running the script. Here is an official example:

```matlab
clc, clear all

X = magic(100);

[F, M, C] = inmem
```

```
F =
  25×1 cell array
    {'desktop'                      }
    {'workspacefunc'                }
    {'Logger'                       }
    {'Manager'                      }
    {'EventSource'                  }
    {'Channel'                      }
    {'MessageHandler'               }
    {'InputStream'                  }
    {'OutputStream'                 }
    {'EditorViewBreakpointStore'    }
    {'getSetWeakSubscriptions'      }
    {'getSetStrongSubscriptions'    }
    {'Subscription'                 }
    {'getSettingsRoot'              }
    {'RedefinesParen.RedefinesParen'}
    {'DocumentAction'               }
    {'ReqData.getInstance'          }
    {'EODataStore'                  }
    {'VEFactory'                    }
    {'FigurePoolManager'            }
    {'ToolstripSubscriber'          }
    {'ExecutionStateTracker'        }
    {'script1'                      }
    {'magic'                        }
    {'MainManager.getInstance'      }


M =
  0×1 empty cell array

C =
  32×1 cell array
    {'string'                                                              }
    {'message'                                                             }
    {'inputParser'                                                         }
    {'asyncioimpl.MessageHandler'                                          }
    {'asyncioimpl.Channel'                                                 }
    {'asyncioimpl.InputStream'                                             }
    {'asyncioimpl.OutputStream'                                            }
    {'event.listener'                                                      }
    {'containers.Map'                                                      }
    {'matlab.settings.SettingsGroup'                                       }
    {'matlab.internal.UrlManager'                                          }
    {'matlab.internal.webservices.HTTPConnectionAdapter'                   }
    {'matlab.display.internal.CompactDisplayProvider'                      }
    {'matlab.graphics.GraphicsPlaceholder'                                 }
    {'matlab.internal.language.ExecutionTracker'                           }
    {'matlab.internal.reference.api.EntityPrecision'                       }
    {'matlab.internal.reference.api.ReferenceRequest'                      }
    {'matlab.internal.reference.api.comparator.EntityNameMatchComparator'  }
    {'matlab.internal.reference.api.comparator.ProductMatchComparator'     }
    {'matlab.internal.reference.api.comparator.EntityTypeOrderComparator'  }
    {'matlab.internal.reference.api.comparator.PreferredOrderComparator'   }
    {'matlab.internal.reference.api.comparator.CompoundReferenceComparator'}
    {'matlab.internal.reference.api.EntityCaseSensitivity'                 }
    {'matlab.internal.reference.api.ReferenceDataRetriever'                }
    {'matlab.depfun.internal.database.SqlDbConnector'                      }
    {'matlab.depfun.internal.WhichCache'                                   }
    {'matlab.depfun.internal.ExistCache'                                   }
    {'matlab.depfun.internal.SymbolResolver'                               }
    {'matlab.depfun.internal.MFileParser'                                  }
    {'matlab.internal.container.graph.Graph'                               }
    {'dictionary'                                                          }
    {'matlab.internal.reference.property.RefEntityType'                    }
```

in which `F`, `M`, and `C` are the list of names of functions, MEX files, and classes that are currently loaded. We can also use `inmem("-completenames")` to get their full name, which includes file path and extension:

```matlab
clc, clear all

X = magic(100);

[F, M, C] = inmem("-completenames")
```

```
F =
  25×1 cell array
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\general\desktop.p'                                                                    }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\codetools\workspacefunc.m'                                                            }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\connector2\logger\+connector\+internal\Logger.p'                                      }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\deviceplugindetection\+internal\+deviceplugindetection\Manager.m'                     }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\hotpluglib\+internal\+hotplug\EventSource.m'                                          }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\asynciolib\+matlabshared\+asyncio\+internal\Channel.m'                                }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\asynciolib\+matlabshared\+asyncio\+internal\MessageHandler.m'                         }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\asynciolib\+matlabshared\+asyncio\+internal\InputStream.m'                            }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\asynciolib\+matlabshared\+asyncio\+internal\OutputStream.m'                           }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\debugger\+matlab\+internal\+debugger\+breakpoints\EditorViewBreakpointStore.p'        }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\connector2\messageservice\+message\+internal\getSetWeakSubscriptions.p'               }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\connector2\messageservice\+message\+internal\getSetStrongSubscriptions.p'             }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\connector2\messageservice\+message\+internal\Subscription.p'                          }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\configtools\+matlab\+internal\getSettingsRoot.m'                                      }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\indexing\+matlab\+mixin\+indexing\@RedefinesParen\RedefinesParen.m'                   }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\system\editor\+matlab\+system\+editor\+internal\DocumentAction.p'                     }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\reqmgt\+slreq\+data\@ReqData\getInstance.p'                                           }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\embeddedoutputs\outpututilities\+matlab\+internal\+editor\EODataStore.p'              }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\datatools\variableeditor\matlab\+internal\+matlab\+variableeditor\+peer\VEFactory.m'  }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\embeddedoutputs\figureoutputs\+matlab\+internal\+editor\+figure\FigurePoolManager.p'  }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\embeddedoutputs\figureoutputs\+matlab\+internal\+editor\+figure\ToolstripSubscriber.p'}
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\codetools\embeddedoutputs\+matlab\+internal\+editor\ExecutionStateTracker.p'          }
    {'C:\Users\whatastarrynight\Desktop\MATLAB identify dependencies\script1.m'                                                           }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\elmat\magic.m'                                                                        }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\reqmgt\+slreq\+app\@MainManager\getInstance.p'                                        }

M =
  0×1 empty cell array

C =
  32×1 cell array
    {'string'                                                              }
    {'message'                                                             }
    {'inputParser'                                                         }
    {'asyncioimpl.MessageHandler'                                          }
    {'asyncioimpl.Channel'                                                 }
    {'asyncioimpl.InputStream'                                             }
    {'asyncioimpl.OutputStream'                                            }
    {'event.listener'                                                      }
    {'containers.Map'                                                      }
    {'matlab.settings.SettingsGroup'                                       }
    {'matlab.internal.UrlManager'                                          }
    {'matlab.internal.webservices.HTTPConnectionAdapter'                   }
    {'matlab.display.internal.CompactDisplayProvider'                      }
    {'matlab.graphics.GraphicsPlaceholder'                                 }
    {'matlab.internal.language.ExecutionTracker'                           }
    {'matlab.internal.reference.api.EntityPrecision'                       }
    {'matlab.internal.reference.api.ReferenceRequest'                      }
    {'matlab.internal.reference.api.comparator.EntityNameMatchComparator'  }
    {'matlab.internal.reference.api.comparator.ProductMatchComparator'     }
    {'matlab.internal.reference.api.comparator.EntityTypeOrderComparator'  }
    {'matlab.internal.reference.api.comparator.PreferredOrderComparator'   }
    {'matlab.internal.reference.api.comparator.CompoundReferenceComparator'}
    {'matlab.internal.reference.api.EntityCaseSensitivity'                 }
    {'matlab.internal.reference.api.ReferenceDataRetriever'                }
    {'matlab.depfun.internal.database.SqlDbConnector'                      }
    {'matlab.depfun.internal.WhichCache'                                   }
    {'matlab.depfun.internal.ExistCache'                                   }
    {'matlab.depfun.internal.SymbolResolver'                               }
    {'matlab.depfun.internal.MFileParser'                                  }
    {'matlab.internal.container.graph.Graph'                               }
    {'dictionary'                                                          }
    {'matlab.internal.reference.property.RefEntityType'                    }
```

<br>

# Method 2: `matlab.codetools.requiredFilesAndProducts` function

MATLAB function `matlab.codetools.requiredFilesAndProducts` can "return a list of the MATLAB program files required to run the program files specified by `files`"[^3]. Take two built-in functions for example, for `magic`:

```matlab
clc, clear all

[fList, pList] = matlab.codetools.requiredFilesAndProducts("magic.m")
{pList.Name}'
```

```
fList =
  0×0 empty cell array

pList = 
  struct with fields:
             Name: 'MATLAB'
          Version: '23.2'
    ProductNumber: 1
          Certain: 1

ans =
  1×1 cell array
    {'MATLAB'}
```

and for `edge`:

```matlab
clc, clear all

[fList, pList] = matlab.codetools.requiredFilesAndProducts("edge.m")
{pList.Name}'
{pList.Version}'
{pList.ProductNumber}'
{pList.Certain}'
```

```
fList =
  0×0 empty cell array

pList = 
  1×2 struct array with fields:
    Name
    Version
    ProductNumber
    Certain

ans =
  2×1 cell array
    {'MATLAB'                  }
    {'Image Processing Toolbox'}

ans =
  2×1 cell array
    {'23.2'}
    {'23.2'}

ans =
  2×1 cell array
    {[ 1]}
    {[17]}

ans =
  2×1 cell array
    {[1]}
    {[1]}
```

Furthermore, we can try another case where functions are user-defined. Create two function files `getRandomNumber.m` and `displayNumber.m`[^3]:

<div id="example"></div>

```matlab
function a = getRandomNumber
    rng shuffle
    a = rand;
end
```

```matlab
function displayNumber
    a = getRandomNumber;
    disp(['Your number is ' num2str(a)])
end
```

then, let’s see the dependencies of functions `getRandomNumber` and `displayNumber`, respectively:

```matlab
clc, clear all

[fList, pList] = matlab.codetools.requiredFilesAndProducts("getRandomNumber.m");
fList', pList

[fList, pList] = matlab.codetools.requiredFilesAndProducts("displayNumber.m");
fList', pList
```

```
ans =
  1×1 cell array
    {'C:\Users\xxxxxxx\Desktop\MATLAB identify dependencies\getRandomNumber.m'}

pList = 
  struct with fields:
             Name: 'MATLAB'
          Version: '23.2'
    ProductNumber: 1
          Certain: 1

ans =
  2×1 cell array
    {'C:\Users\xxxxxxx\Desktop\MATLAB identify dependencies\displayNumber.m'  }
    {'C:\Users\xxxxxxx\Desktop\MATLAB identify dependencies\getRandomNumber.m'}

pList = 
  struct with fields:
             Name: 'MATLAB'
          Version: '23.2'
    ProductNumber: 1
          Certain: 1
```

<div class="notice--primary" markdown="1">

We can also use the `inmem` function at this case (the following script file is named as `script.m`):

```matlab
clc, clear all

displayNumber

[F, M, C] = inmem("-completenames")
```

```
Your number is 0.98567

F =
  31×1 cell array
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\general\desktop.p'                                                                    }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\debugger\+matlab\+internal\+debugger\+breakpoints\EditorViewBreakpointStore.p'        }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\connector2\logger\+connector\+internal\Logger.p'                                      }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\connector2\messageservice\+message\+internal\getSetWeakSubscriptions.p'               }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\connector2\messageservice\+message\+internal\getSetStrongSubscriptions.p'             }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\strfun\num2str.m'                                                                     }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\connector2\messageservice\+message\+internal\Subscription.p'                          }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\configtools\+matlab\+internal\getSettingsRoot.m'                                      }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\reqmgt\+slreq\+app\@MainManager\getInstance.p'                                        }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\reqmgt\+slreq\+data\@ReqData\getInstance.p'                                           }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\timefun\datenum.m'                                                                    }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\codetools\workspacefunc.m'                                                            }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\timefun\now.m'                                                                        }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\deviceplugindetection\+internal\+deviceplugindetection\Manager.m'                     }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\hotpluglib\+internal\+hotplug\EventSource.m'                                          }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\asynciolib\+matlabshared\+asyncio\+internal\Channel.m'                                }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\asynciolib\+matlabshared\+asyncio\+internal\MessageHandler.m'                         }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\asynciolib\+matlabshared\+asyncio\+internal\InputStream.m'                            }
    {'C:\Program Files\MATLAB\R2023b\toolbox\shared\asynciolib\+matlabshared\+asyncio\+internal\OutputStream.m'                           }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\indexing\+matlab\+mixin\+indexing\@RedefinesParen\RedefinesParen.m'                   }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\system\editor\+matlab\+system\+editor\+internal\DocumentAction.p'                     }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\embeddedoutputs\outpututilities\+matlab\+internal\+editor\EODataStore.p'              }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\datatools\variableeditor\matlab\+internal\+matlab\+variableeditor\+peer\VEFactory.m'  }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\embeddedoutputs\figureoutputs\+matlab\+internal\+editor\+figure\FigurePoolManager.p'  }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\embeddedoutputs\figureoutputs\+matlab\+internal\+editor\+figure\ToolstripSubscriber.p'}
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\codetools\embeddedoutputs\+matlab\+internal\+editor\ExecutionStateTracker.p'          }
    {'C:\Users\xxxxxxx\Desktop\MATLAB identify dependencies\script.m'                                                            }
    {'C:\Users\xxxxxxx\Desktop\MATLAB identify dependencies\getRandomNumber.m'                                                   }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\randfun\rng.m'                                                                        }
    {'C:\Users\xxxxxxx\Desktop\MATLAB identify dependencies\displayNumber.m'                                                     }
    {'C:\Program Files\MATLAB\R2023b\toolbox\matlab\randfun\@RandStream\RandStream.m'                                                     }

M =
  0×1 empty cell array

C =
  23×1 cell array
    {'string'                                           }
    {'containers.Map'                                   }
    {'inputParser'                                      }
    {'matlab.settings.SettingsGroup'                    }
    {'message'                                          }
    {'asyncioimpl.MessageHandler'                       }
    {'asyncioimpl.Channel'                              }
    {'asyncioimpl.InputStream'                          }
    {'asyncioimpl.OutputStream'                         }
    {'event.listener'                                   }
    {'matlab.internal.UrlManager'                       }
    {'matlab.internal.webservices.HTTPConnectionAdapter'}
    {'matlab.depfun.internal.database.SqlDbConnector'   }
    {'matlab.depfun.internal.WhichCache'                }
    {'matlab.depfun.internal.ExistCache'                }
    {'matlab.depfun.internal.SymbolResolver'            }
    {'matlab.depfun.internal.MFileParser'               }
    {'dictionary'                                       }
    {'matlab.display.internal.CompactDisplayProvider'   }
    {'matlab.graphics.GraphicsPlaceholder'              }
    {'matlab.internal.language.ExecutionTracker'        }
    {'matlab.internal.container.graph.Graph'            }
    {'RandStream'                                       }
```

We can find above two function files and the script file in the variable `M`:

```
    ......
    {'C:\Users\xxxxxxx\Desktop\MATLAB identify dependencies\script.m'                                                            }
    {'C:\Users\xxxxxxx\Desktop\MATLAB identify dependencies\getRandomNumber.m'                                                   }
    ......
    {'C:\Users\xxxxxxx\Desktop\MATLAB identify dependencies\displayNumber.m'                                                     }
    ......
```

So, as can be seen, by using `inmem` function we can get more fundamental functions that are called.

</div>

<br>

# Method 3: MATLAB APP Dependency Analyzer

At last, we can also use MATLAB APP Dependency Analyzer to analyze dependencies[^1]. Still take the [above simple example](#example), we have:

![image-20250721133302035](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202507211333170.png)

<br>

**References**

[^1]: [Identify Program Dependencies](https://www.mathworks.com/help/matlab/matlab_prog/identify-dependencies.html).
[^2]: [MATLAB `inmem`: Names of functions, MEX files, and classes in memory](https://www.mathworks.com/help/matlab/ref/inmem.html).
[^3]: [MATLAB `matlab.codetools.requiredFilesAndProducts`: List dependencies of MATLAB program files](https://www.mathworks.com/help/matlab/ref/matlab.codetools.requiredfilesandproducts.html).
