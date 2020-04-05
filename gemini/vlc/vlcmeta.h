#ifndef VLCMETA_H
#define VLCMETA_H

#include <vlc/vlc.h>

#include <QString>
#include <QObject>

namespace vlc {

struct Meta {
    Q_GADGET
    Q_PROPERTY(QString title MEMBER m_title CONSTANT)
    Q_PROPERTY(QString artist MEMBER m_artist CONSTANT)
    Q_PROPERTY(QString url MEMBER m_url CONSTANT)
    Q_PROPERTY(QString date MEMBER m_date CONSTANT)

public:
    QString m_title;
    QString m_artist;
    QString m_url;
    QString m_date;

    static Meta load(libvlc_media_t *vlcMedia);
};

}

Q_DECLARE_METATYPE(vlc::Meta)

#endif // VLCMETA_H
