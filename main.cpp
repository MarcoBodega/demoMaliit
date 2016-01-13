#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QQmlEngine>
#include <QQmlContext>
#include <QtQuick/QQuickItem>

#include <QProcessEnvironment>
#include <QDebug>


#include <qpa/qplatforminputcontextfactory_p.h>
#include <qpa/qplatformintegration.h>
#include <qpa/qplatforminputcontext.h>
#include <private/qguiapplication_p.h>

#ifdef MALIIT
/*
#include <mimpluginmanager.h>
#include <minputcontextconnection.h>
#include <mimserver.h>
#include <connectionfactory.h>
#include <unknownplatform.h>
#include <maliitsettingsmanager.h>
*/
#endif

#ifdef MOCKUP
#include "mockupplatforminputcontextplugin.h"
#endif


/*
 * ENVIRONMENT
 *
 * #QT_QPA_EGLFS_DEBUG = qt.qpa.egldeviceintegration
 * #QT_QPA_EGLFS_DEBUG = qt.qpa.input
 *
 * QT_DEBUG_PLUGINS = 1
 * MALIIT_DEBUG = 1
 *
 * QT_PLUGIN_PATH or QCoreApplication::setLibraryPaths
 *
 * QT_IM_MODULE = maliit
 *
 *
 * */



int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);
	//QQmlApplicationEngine engine;
	QQuickView viewer;

#ifdef MALIIT

	// set paths here or in QT_PLUGIN_PATH
	QCoreApplication::setLibraryPaths(QStringList() << "/usr/lib/x86_64-linux-gnu/qt5/plugins/"
							  <<"/usr/local/lib/qt5/plugins/");

	QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
	if (env.contains("QT_IM_MODULE"))
	{
		// INPUT METHOD PART
		QInputMethod *im = QGuiApplication::inputMethod();
		if(!im) {
			qDebug() << "unable to get QInputMethod";
			exit(0);
		}
		qDebug() << "QInputMethod im is = "<<im;

		//INPUT CONTEXT PART
		QString module = env.value("QT_IM_MODULE"); // should me "maliit"
		qDebug() << "Trying to load input module" << module;
		QPlatformInputContext *ic = QPlatformInputContextFactory::create(module); // create(); // depends from QT_IM_MODULE!!
		if(!ic) {
			qDebug() << "unable to get QPlatformInputContext";
			exit(0);
		}
		qDebug() << "QPlatformInputContext ic is = "<< ic;
		ic->showInputPanel();
		//engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
		viewer.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
		viewer.show();

		viewer.rootContext()->setContextProperty("hasEmbeddedKeyboard", QVariant(true));

		//addMaliitSurfaces(viewer.scene(), Maliit::InputMethod::instance()->widget());

		return app.exec();
	}
#endif

#ifdef MOCKUP


	QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
	//QT_IM_MODULE=mockup
	QString module = env.value("QT_IM_MODULE"); // should me "mockup"
	qDebug() << "Trying to load input module" << module;

	QInputMethod *im = QGuiApplication::inputMethod();
	if(!im) {
		qDebug() << "unable to get QInputMethod";
		exit(0);
	}
	qDebug() << "QInputMethod im is = "<< im;
	QPlatformInputContext *ic = QPlatformInputContextFactory::create(module); // create(); // depends from QT_IM_MODULE!!
	if(!ic) {
		qDebug() << "unable to get QPlatformInputContext";
		exit(0);
	}
	qDebug() << "QPlatformInputContext ic is = "<< ic;
	ic->showInputPanel();
	im->show();

	viewer.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
	viewer.show();

	return app.exec();
#endif

}




/*
void addMaliitSurfaces(QGraphicsScene *scene, QWidget *root)
{
	foreach (QObject *c, root->children())
	{
		QGraphicsView *view = qobject_cast<QGraphicsView *>(c);
		if (!view)
			continue;

		view->setParent(0);

		QGraphicsProxyWidget *wid = new QGraphicsProxyWidget;

		wid->setWidget(view);
		wid->setFocusPolicy(Qt::NoFocus);

		scene->addItem(wid);

		addMaliitSurfaces(scene, view);
	}
}*/

